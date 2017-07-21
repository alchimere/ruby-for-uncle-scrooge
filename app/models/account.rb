# coding: utf-8
require 'hippie_csv'
require 'selenium-webdriver'
require 'watir'
require 'headless'

class Account < ApplicationRecord

  has_many :operations

  def import_csv(file_path)
    rows = HippieCSV.read(file_path)
    self.transaction do
      rows.each do |row|
        next unless row[0].match(/\d+\/\d+\/\d+/)
        Rails.logger.warn(row.to_json)
        op_data = row_to_operation(row)
        if self.operations.exists?(operation_date: op_data[:operation_date],
                                   amount: op_data[:amount],
                                   original_name: op_data[:original_name])
          puts "Operation already exists --> skip"
        else
          op = self.operations.build(op_data)
          op.save!
        end
      end
    end
  end

  def download_file! password
    imported_filepath = nil
    headless = Headless.new
    headless.start
    begin
      thread = nil
      profile = Selenium::WebDriver::Chrome::Profile.new
      download_dir = File.join(Rails.root, 'lib', 'assets')
      profile['download.default_directory'] = download_dir
      profile['download.prompt_for_download'] = false

      browser = Watir::Browser.new(:chrome, profile: profile)
      begin
        # Ident
        browser.goto("https://www.creditmutuel.fr/fr/authentification.html")
        browser.text_field(id: '_userid').set("3640310199803")
        browser.text_field(id: '_pwduser').set(password.to_s)
        browser.form(id: 'bloc_ident').submit
        # Download
        browser.goto("https://www.creditmutuel.fr/fr/banque/compte/telechargement.cgi")
        browser.input(id: 'csv:DataEntry').click
        browser.input(id: 'F_0.accountCheckbox:DataEntry')
          .tap { |box| box.click unless box.checked? }

        notifier = INotify::Notifier.new
        notifier.watch(download_dir, :moved_to, :create) do |event|
          if event.name.ends_with?('.csv')
            imported_filepath = download_dir + '/' + event.name
            notifier.stop
          end
          puts "'#{event.name}' is now in #{download_dir}!"
        end
        thread = Thread.new { Timeout.timeout(5) { notifier.run } }
        sleep 1
        browser.input(name: '_FID_DoDownload').click
        thread.join
      ensure
        browser.close
      end
    ensure
      headless.destroy
    end

    import_csv(imported_filepath)
  end

  private
  def row_to_operation(row)
    Rails.logger.info row[0]
    {
      operation_category_id: OperationCategory.first.id,
      name: row[4],
      original_name: row[4],
      amount: extract_amount(row),
      operation_date: Date.parse(row[0])
    }.tap { |op|
      puts "row_to_operation ==> #{op.to_json}"
    }
  end

  def extract_amount(row)
    (row[2].presence || row[3].presence).try(:tr, ',', '.').to_f
  end
end
