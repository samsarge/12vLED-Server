#(http://rubygems.org/gems/serialport)

require "sinatra" 
require "serialport"
require_relative "./color_converter"

# COM3/4 for windows.
# otherwise TTY
PORT_STR = "COM4"
BAUD_RATE = 9600
DATA_BITS = 8
STOP_BITS = 1
PARITY = SerialPort::NONE
 
SERIALPORT = SerialPort.new(PORT_STR, BAUD_RATE, DATA_BITS, STOP_BITS, PARITY)

get '/' do
  erb :index
end

post '/color' do
  hex = params["Color Wheel"]
  rgb = ColorConverter.rgb(hex)
  payload = rgb.join(':')
  SERIALPORT.write(payload)
  SERIALPORT.flush
  redirect '/'
end

#SERIALPORT.close
