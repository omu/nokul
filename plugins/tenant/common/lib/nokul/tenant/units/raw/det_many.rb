# frozen_string_literal: true

# DETSİS units at raw form

module Nokul
  module Tenant
    module Units
      module Raw
        class DETMany < Support::UniqCollection
          include Concerns::RawMany
          using   Concerns::Refinery

          collection.source   = 'db/units/raw/det.yml'
          collection.label    = 'DETSİS ham birimler'
          collection.collects = DETOne
          collection.produces = Src::DETMany

          # rubocop:disable Layout/AlignHash
          class_attribute :mapping, default: {
            name:                         proc { |raw| raw.name.split('>').last&.capitalize_and_fix },
            detsis_id:                    proc { |raw| raw.detsis_id&.to_s },
            parent_detsis_id:             proc { |raw| raw.parent_detsis_id&.to_s },
            unit_status_id:               proc do |raw|
              next 'Aktif'      if raw.active &&  raw.activity
              next 'Yarı Pasif' if raw.active && !raw.activity

              'Pasif'
            end
          }

          TYPES = {
            'Rektörlük'                           => /Rektörlüğü/,
            'Senato'                              => /Senato/,
            'Üniversite Yönetim Kurulu'           => /Üniversite Yönetim Kurulu/,
            'Üniversite Disiplin Kurulu'          => /Üniversite Disiplin Kurulu/,
            'Üniversite Sekreterliği'             => /Genel Sekreterlik/,
            # -
            'Merkez Müdürlüğü'                    => /Merkez\S* Müdürlüğü/,
            # -
            'Enstitü Müdürlüğü'                   => /Enstitü\S* Müdürlüğü/,
            'Enstitü Kurulu'                      => /Enstitü\S* Kurulu/,
            'Enstitü Yönetim Kurulu'              => /Enstitü\S* Yönetim Kurulu/,
            'Enstitü Disiplin Kurulu'             => /Enstitü\S* Disiplin Kurulu/,
            'Enstitü Sekreterliği'                => /Enstitü\S* Sekreterliği/,
            # -
            'Meslek Yüksekokulu Müdürlüğü'        => /Meslek Yüksekokulu Müdürlüğü/,
            'Meslek Yüksekokulu Kurulu'           => /Meslek Yüksekokulu Kurulu/,
            'Meslek Yüksekokulu Yönetim Kurulu'   => /Meslek Yüksekokulu Yönetim Kurulu/,
            'Meslek Yüksekokulu Disiplin Kurulu'  => /Meslek Yüksekokulu Disiplin Kurulu/,
            'Meslek Yüksekokulu Sekreterliği'     => /Meslek Yüksekokulu Sekreterliği/,
            # -
            'Fakülte Dekanlığı'                   => /Fakülte\S* Dekanlığı/,
            'Fakülte Kurulu'                      => /Fakülte\S* Kurulu/,
            'Fakülte Yönetim Kurulu'              => /Fakülte\S* Yönetim Kurulu/,
            'Fakülte Disiplin Kurulu'             => /Fakülte\S* Disiplin Kurulu/,
            'Fakülte Sekreterliği'                => /Fakülte\S* Sekreterliği/,
            # -
            'Konservatuvar Müdürlüğü'             => /Konservatuvar\S* Müdürlüğü/,
            'Konservatuvar Kurulu'                => /Konservatuvar\S* Kurulu/,
            'Konservatuvar Yönetim Kurulu'        => /Konservatuvar\S* Yönetim Kurulu/,
            'Konservatuvar Disiplin Kurulu'       => /Konservatuvar\S* Disiplin Kurulu/,
            'Konservatuvar Sekreterliği'          => /Konservatuvar\S* Sekreterliği/,
            # -
            'Bölüm Başkanlığı'                    => /Bölüm\S* Başkanlığı/,
            'Anabilim Dalı Başkanlığı'            => /Anabilim Dalı Başkanlığı/,
            'Anasanat Dalı Başkanlığı'            => /Anasanat Dalı Başkanlığı/,
            # -
            'Başmüdürlük'                         => /Başmüdürlü\S*/,
            'Başhekimlik'                         => /Başhekimli\S*/,
            # -
            'Şube Müdürlüğü'                      => /Şube\S* Müdürlüğü/,
            'Daire Başkanlığı'                    => /Daire\S* Başkanlığı/,
            # -
            'Etik Kurul'                          => /Etik Kurul/,
            'Koordinatörlük'                      => /Koordinatörlüğü/,
            'Diğer Kurul'                         => /Kurul/,
            'Diğer Komisyon'                      => /Komisyon/
          }.freeze
          # rubocop:enable Layout/AlignHash

          mapping[:unit_type_id] = proc do |raw|
            name = mapping[:name].call(raw)

            TYPES.keys.find do |type|
              name =~ TYPES[type]
            end || 'Diğer İdari Birim'
          end

          mapping.freeze

          END_POINT = 'https://api.omu.sh/detsis/units'

          def self.fetch
            root_id = config.fetching.det.root_id
            File.write Tenant.root.join(collection.source), create.fetch(root_id).as_canonical_yaml_string
          end

          def fetch(root_id)
            produce_units.each do |unit|
              unit.parent_detsis_id = 0 if unit.detsis_id.to_s == root_id.to_s
              populate(unit)
            end

            self
          end

          def produce_units
            response = Xokul.request(END_POINT)
            return [] unless response.ok?

            [response.decode || []].flatten.map! do |args|
              self.class.collects.new(**args.symbolize_keys)
            end
          rescue Net::HTTPError
            []
          end

          def populate(unit)
            self << unit
            puts format("%<number>4d\t%<label>s", number: size, label: unit.label)
            unit
          end
        end
      end
    end
  end
end
