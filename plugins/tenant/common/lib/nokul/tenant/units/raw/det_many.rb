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

          # rubocop:disable Layout/HashAlignment
          class_attribute :mapping, default: {
            name:                         proc { |raw| raw.name.split('>').last&.capitalize_and_fix },
            detsis_id:                    proc { |raw| raw.detsis_id&.to_i },
            parent_detsis_id:             proc { |raw| raw.parent_administrative_identity_code&.to_i },
            unit_status_id:               proc do |raw|
              next 'Aktif'      if raw.active &&  raw.activity
              next 'Yarı Pasif' if raw.active && !raw.activity

              'Pasif'
            end
          }

          TYPES = {
            'Rektörlük'                     => /Rektörlüğü/,
            'Senato'                        => /Senato/,
            'Üniversite Yönetim Kurulu'     => /Üniversite Yönetim Kurulu/,
            'Üniversite Disiplin Kurulu'    => /Üniversite Disiplin Kurulu/,
            'Üniversite Sekreterliği'       => /Genel Sekreterlik/,
            # -
            'Merkez Müdürlüğü'              => /Merkez\S* Müdürlüğü/,
            # -
            'Enstitü Müdürlüğü'             => /Enstitü\S* Müdürlüğü/,
            'Enstitü Kurulu'                => /Enstitü\S* Kurulu/,
            'Enstitü Yönetim Kurulu'        => /Enstitü\S* Yönetim Kurulu/,
            'Enstitü Disiplin Kurulu'       => /Enstitü\S* Disiplin Kurulu/,
            'Enstitü Sekreterliği'          => /Enstitü\S* Sekreterliği/,
            # -
            'Yüksekokul Müdürlüğü'          => /Yüksekokul\S* Müdürlüğü/,
            'Yüksekokul Kurulu'             => /Yüksekokul\S* Kurulu/,
            'Yüksekokul Yönetim Kurulu'     => /Yüksekokul\S* Yönetim Kurulu/,
            'Yüksekokul Disiplin Kurulu'    => /Yüksekokul\S* Disiplin Kurulu/,
            'Yüksekokul Sekreterliği'       => /Yüksekokul\S* Sekreterliği/,
            # -
            'Fakülte Dekanlığı'             => /Fakülte\S* Dekanlığı/,
            'Fakülte Kurulu'                => /Fakülte\S* Kurulu/,
            'Fakülte Yönetim Kurulu'        => /Fakülte\S* Yönetim Kurulu/,
            'Fakülte Disiplin Kurulu'       => /Fakülte\S* Disiplin Kurulu/,
            'Fakülte Sekreterliği'          => /Fakülte\S* Sekreterliği/,
            # -
            'Konservatuvar Müdürlüğü'       => /Konservatuvar\S* Müdürlüğü/,
            'Konservatuvar Kurulu'          => /Konservatuvar\S* Kurulu/,
            'Konservatuvar Yönetim Kurulu'  => /Konservatuvar\S* Yönetim Kurulu/,
            'Konservatuvar Disiplin Kurulu' => /Konservatuvar\S* Disiplin Kurulu/,
            'Konservatuvar Sekreterliği'    => /Konservatuvar\S* Sekreterliği/,
            # -
            'Bölüm Başkanlığı'              => /Bölüm\S* Başkanlığı/,
            'Anabilim Dalı Başkanlığı'      => /Anabilim Dalı Başkanlığı/,
            'Anasanat Dalı Başkanlığı'      => /Anasanat Dalı Başkanlığı/,
            # -
            'Başmüdürlük'                   => /Başmüdürlü\S*/,
            'Başhekimlik'                   => /Başhekimli\S*/,
            # -
            'Şube Müdürlüğü'                => /Şube\S* Müdürlüğü/,
            'Daire Başkanlığı'              => /Daire\S* Başkanlığı/,
            # -
            'Etik Kurul'                    => /Etik Kurul/,
            'Koordinatörlük'                => /Koordinatörlüğü/,
            'Diğer Kurul'                   => /Kurul/,
            'Diğer Komisyon'                => /Komisyon/
          }.freeze
          # rubocop:enable Layout/HashAlignment

          mapping[:unit_type_id] = proc do |raw|
            name = mapping[:name].call(raw)

            TYPES.keys.find do |type|
              name =~ TYPES[type]
            end || 'Diğer İdari Birim'
          end

          mapping.freeze

          END_POINT = 'https://api.omu.sh/detsis/units'

          def self.fetch
            root_id = config.fetching.det.root_id.to_i
            File.write Tenant.root.join(collection.source), create.fetch(root_id).as_canonical_yaml_string
          end

          def fetch(root_id)
            mark_root(produce_units).each { |unit| populate(unit) }
            self
          end

          def mark_root(units)
            root = units.find { |unit| !unit.detsis_id.nil? && unit.detsis_id.to_i == root_id.to_i }
            root.parent_administrative_identity_code = 0
            units
          end

          def produce_units
            response = Xokul.request(END_POINT)
            return [] unless response && response.ok?

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
