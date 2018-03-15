namespace :yoksis do
  namespace :referanslar do
    task :pozisyonlar do
      client = Services::Yoksis::V1::Referanslar.new
      response = client.get_personel_gorev

      name = client.class.to_s.split('::')[1]
      endpoint = client.class.to_s.split('::')[3]
      action = response.keys.first.to_s
      sha1 = Digest::SHA1.hexdigest(response.to_s)

      current_response = YoksisResponse.find_by(name: name, endpoint: endpoint, action: action)

      if current_response
        if current_response.sha1.eql?(sha1)
          current_response.touch(:syncronized_at)
        else
          # TODO: Notify operators to check changes at YOKSIS API. Never trust data coming from YOKSIS, check manually.
          YoksisResponse.create(name: name, endpoint: endpoint, action: action, sha1: sha1)
        end
      else
        response.values.first[:referanslar].each do |referans|
          Position.create!(name: referans[:ad], yoksis_id: referans[:kod])
        end
        YoksisResponse.create!(name: name, endpoint: endpoint, action: action, sha1: sha1)
      end
    end
  end
end
