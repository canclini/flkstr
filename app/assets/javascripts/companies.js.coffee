jQuery -> 
  new LogoCropper()
  
class LogoCropper
  constructor: ->
    $('#cropbox').Jcrop
      aspectRatio: 1
      setSelect: [0,0,600,600]
      onSelect: @update
      onChange: @update
  update: (coords) =>
    $('#company_crop_x').val(coords.x)
    $('#company_crop_y').val(coords.y)
    $('#company_crop_w').val(coords.w)
    $('#company_crop_h').val(coords.h)