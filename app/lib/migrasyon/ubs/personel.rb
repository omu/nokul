# frozen_string_literal: true

require_relative 'personel/connection'

module Migrasyon
  module Ubs
    module Personel
      module_function

      def tables
        connection = Connection.new

        tables = connection.client.execute(
          "SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE='BASE TABLE'"
        ).each

        return tables

        connection.close
      end

      def drop_empty_tables
        drop_tables(
          YAML.load_file(
            Rails.root.join('app', 'lib', 'migrasyon', 'ubs', 'personel', 'empty_tables.yml')
          )
        )
      end

      def drop_backup_tables
        drop_tables(
          YAML.load_file(
            Rails.root.join('app', 'lib', 'migrasyon', 'ubs', 'personel', 'backup_tables.yml')
          )
        )
      end

      def migrate_users
        connection = Connection.new

        result = connection.client.execute(
          "SELECT PersonelID, KimlikNo, PersonelTip, Aktif FROM Personel"
        )

        result.each do |personel|
          personel["PersonelTip"] = 'Memur' if personel["PersonelTip"].eql?(2000100001)
          personel["PersonelTip"] = 'İşçi' if personel["PersonelTip"].eql?(2000100002)
          personel["PersonelTip"] = '4B' if personel["PersonelTip"].eql?(2000100003)
          personel["PersonelTip"] = 'Taşeron' if personel["PersonelTip"].eql?(2000100004)
        end

        result.each do |personel|
          adres_result = connection.client.execute(
            "SELECT EMail FROM Adres WHERE Personel = #{personel['PersonelID']}"
          )

          if adres_result.count == 0
            email = "#{personel["KimlikNo"]}@omu.edu.tr"
          elsif adres_result.count == 1 && adres_result["EMail"].present?
            email = adres_result["EMail"]
          elsif adres_result.count == 1 && adres_result["EMail"].blank?
            email = "#{personel["KimlikNo"]}@omu.edu.tr"
          elsif adres_result.count == 2
            
          end
        end

        # result = connection.client.execute(
        #   "SELECT p.*, a.Email FROM Personel AS p \
        #   JOIN Adres AS a ON p.PersonelID = a.Personel WHERE p.KimlikNo = '14041515584'"
        # )

        # result.each do |personel|
        #   email = if personel["Email"].present?
        #             personel["Email"]
        #           else
        #             "#{personel["KimlikNo"]}@omu.edu.tr"
        #           end

        #   password = personel["KimlikNo"] + personel["Soyadi"][0..2]

        #   user = User.new(
        #     id_number: personel["KimlikNo"],
        #     email: email,
        #     password: password,
        #     password_confirmation: password
        #   )

        #   File.write(
        #     Rails.root.join('errors.txt'),
        #     "#{user.id_number} : #{email} => #{user.errors.messages} \n",
        #     mode: 'a'
        #   ) unless user.save
        # end

        connection.close
      end

      def drop_tables(list)
        connection = Connection.new
        affected_rows = 0

        list.each do |table|
          result = connection.client.execute("DROP TABLE IF EXISTS dbo.#{table['name']}")
          affected_rows += result.affected_rows
        end

        puts "#{affected_rows} tables affected!"

        connection.close
      end
    end
  end
end
