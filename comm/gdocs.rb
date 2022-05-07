GDOCS ||= {
    foo: {
      spreadsheet: "https://docs.google.com/spreadsheets/", 
      json: "https://spreadsheets.google.com/feeds/public/values?alt=json",
      collection: 'foo1'
    },
  }.hwia

# HOW TO:
# https://www.freecodecamp.org/news/cjn-google-sheets-as-json-endpoint/
# Endpoint: https://spreadsheets.google.com/feeds/cells/YOURGOOGLESHEETCODE/SHEETPAGENUMBER/public/full?alt=json

# https://spreadsheets.google.com/feeds/cells/1_wpkZvVMfoGYklLMVFFSdXU2mhKNePNtJfItkrBmI7w/1/public/full?alt=json
# https://docs.google.com/spreadsheets/d/1_wpkZvVMfoGYklLMVFFSdXU2mhKNePNtJfItkrBmI7w/edit#gid=821779876



get '/admin/pull_gdoc' do
  #return {msg: "ok"}
  require_fields(['uri','col'])
  rows = gdoc_to_rows_arr(params[:uri])
  col  = $mongo.collection(params[:col])
  rows.each {|r| col.add(r) }
  flash.message="Added #{rows.size} items to #{params[:col]}"
  redirect '/admin'
end

def gdoc_to_rows_arr(uri)
  json       = JSON.parse(open(uri).read)['feed']['entry']
  data_cells = json.map { |row| kvs = row.select {|k,v| k.start_with?('gsx$') } } 
  ready_rows = data_cells.map {|row| row = row.map {|k,v| [k.sub('gsx$',''),v['$t'] ]; }.to_h }
  ready_rows
rescue => e
  {msg: e}
end