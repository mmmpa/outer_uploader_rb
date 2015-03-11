require 'securerandom'

class UploadedFile
  class << self
    def from=(val)
      @from = val
    end


    def from
      @from || (raise 'not yet')
    end
  end


  def initialize(form_hash)
    @ext = File.extname(form_hash['upload_file[filename]'].first)
    @temp = form_hash['upload_file[tempfile]'].first
    @size = form_hash['upload_file[size]'].first
  end


  def move
    begin
      name = SecureRandom.uuid + @ext
      to = [UploadedFile.from, name].join('/')
    end while File.exist?(to)

    if File.rename(@temp, to) == 0
      {result: 'ok', name: name}
    else
      {result: 'ng'}
    end
  end
end
