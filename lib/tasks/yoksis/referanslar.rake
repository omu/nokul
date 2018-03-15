namespace :yoksis do
  namespace :referanslar do
    task :pozisyonlar => [:define_client] do
      response = @client.get_personel_gorev
      calculate_sha1(response)
      find_current_response

      if @current_response
        if @current_response.sha1.eql?(@sha1)
          @current_response.touch(:syncronized_at)
        else
          # TODO: Notify operators to check changes at YOKSIS API. Never trust data coming from YOKSIS, check manually.
          create_yoksis_response
        end
      else
        response.values.first[:referanslar].each do |referans|
          Position.create!(name: referans[:ad], yoksis_id: referans[:kod])
        end
        create_yoksis_response
      end
    end

    # common tasks for other tasks
    task :define_client do
      @client = Services::Yoksis::V1::Referanslar.new
      @name = @client.class.to_s.split('::')[1]
      @endpoint = @client.class.to_s.split('::')[3]
    end

    # common methods for other tasks
    def calculate_sha1(response)
      @action = response.keys.first.to_s
      @sha1 = Digest::SHA1.hexdigest(response.to_s)
    end

    def find_current_response
      @current_response = YoksisResponse.find_by(name: @name, endpoint: @endpoint, action: @action)
    end

    def create_yoksis_response
      YoksisResponse.create!(name: @name, endpoint: @endpoint, action: @action, sha1: @sha1)
    end
  end
end
