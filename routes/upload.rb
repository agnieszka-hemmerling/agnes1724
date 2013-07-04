require 'yaml'
require 'RMagick'
include Magick
routes do
  helpers Sinatra::JSON


  get '/photos/upload' do
    @responses = []
    @current_user.photos.each do |p|
      photo = {}
      photo[:url] = p.url
      photo[:thumb_url] = p.thumb_url
      photo[:created_ago] = p.created_ago
      photo[:filename] = p.filename
      @responses.push photo
    end
    return @responses.to_json
  end

  post '/settings/avatar' do
    @current_user.avatar_url = params[:avatar_url]
    @current_user.save
  end

  delete '/photos/upload/:name' do
    Photo.first(:filename => params[:name]).destroy
    File.delete("public/files/#{params[:name]}")
    File.delete("public/files/thumb_#{params[:name]}")
    204
    
  end

  
  post '/classified/photo' do
    @filename = params[:qqfile]
    @path = "public/files/#{@filename}"

    @file = File.open(@path, "wb")
    @file.write request.body.read

    @photo = Photo.create(:filename => @filename)

    response = {}
    response[:success] = true
    response[:photo_id] = @photo.id

    return [200, response.to_json]
  end


  post '/photos/upload' do
    filename = params[:qqfile]
    @path = "public/files/#{filename}"

    @thumb_name = 'thumb_' + filename
    @path = "public/files/#{filename}"
    @thumb_path = "public/files/#{thumb_name}"


    @file = File.open(path, "wb")
    @file.write request.body.read

    @img = Image.read(path).first
    @thumb = img.scale(100, 100)
    @thumb.write  thumb_path


    @photo = Photo.create :filename => filename
    @current_user.photos.push photo
    @current_user.save

    @photo_hash = {}
    @photo_hash[:thumb_url] = photo.thumb_url
    @photo_hash[:created_ago] = photo.created_ago
    @photo_hash[:filename] = photo.filename

    return [200, {success: true, photo: photo_hash}.to_json]
#    return [200, {success: true}.to_json]
  end





  post '/photos/upload.old' do
    
    @responses = []

    params[:files].each do |file|

      response = {}


      tmpfile = file[:tempfile]
      name = file[:filename]

      response[:name] =  name


      unless file and tmpfile and name
        flash[:error] = "No file selected"
        redirect :'/photos/upload'
      end

      directory = "files"
      path = File.join('public', directory, name)
      path = "public/files/#{name}"

      file = File.open(path, "wb") { |f| f.write(tmpfile.read) }


      @image_path = File.join('/files', name)



      thumb_name = 'thumb_' + name
      img = Image.read(path).first
      thumb = img.scale(100, 100)
      thumb.write  File.join('public', directory, thumb_name)

      response[:thumbnail_url] = "/files/#{thumb_name}"
      response[:delete_url] = "photos/#{name}"
      response[:delete_type] = 'DELETE'
      

      response[:url] =  @image_path

      photo = Photo.new
      photo.url = @image_path
      photo.thumb_url = @response[:thumbnail_url]
      photo.user_id = @current_user.id
      @current_user.photos << photo
      @current_user.save!

      @responses << response
    end

    #gallery = Gallery.new
    #gallery.title = @image_path

    #@current_user.galleries << gallery
    #@current_user.save!

    json @responses
  end

end
=begin
post '/photos/upload' do
#    unless params[:avatar_url] &&
(tmpfile = params[:avatar_url][:tempfile]) &&
(name = params[:avatar_url][:filename])
flash[:error] = "No file selected"
return redirect :'/photos/upload'
else 
directory = "files"
path = File.join('public', directory, name)
file = File.open(path, "wb") { |f| f.write(tmpfile.read) }
slim  "h1 Upload complete"
@image_path = File.join('files', name)
$db.execute "UPDATE users SET avatar_url='#{@image_path}' WHERE users.id='#{session[:user_id]}'"
@current_user.avatar_url = @image_path
@current_user.save!
return slim :'/photos/upload'
end
=end


