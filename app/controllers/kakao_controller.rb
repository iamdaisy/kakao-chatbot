require 'msg_maker'
require 'parser'

class KakaoController < ApplicationController
  
  @@keyboard = Msg_maker::Keyboard.new
  @@message = Msg_maker::Message.new
  
  def keyboard
    render json: @@keyboard.getBtnKey(["로또", "메뉴", "고양이", "영화"])
  end

  def message
    
    basic_keyboard = @@keyboard.getBtnKey(["로또", "메뉴", "고양이", "영화"])
  
    user_msg = params[:content]
    
    if user_msg == "로또"
      parse = Parser::Lotto.new
      msg = @@message.getMessage(parse.num)
      
    elsif user_msg == "메뉴"
     parse = Parser::Menu.new
     msg = @@message.getMessage(parse.food)
      
    elsif user_msg == "고양이"
      parse = Parser::Animal.new
      msg = @@message.getPicMessage("나만 고양이 없어!", parse.cat)
    
    elsif user_msg == "영화"
      parse = Parser::Movie.new
      msg = @@message.getMessage(parse.naver)
  
    else
      msg = @@message.getMessage("없는 명령어 입니다.")
    end
    
    result = {
      message: msg,
      keyboard: basic_keyboard
    }
    

    render json: result
    
  end
  
  def friend_add
    user_key = params[:user_key]
    # 새로운 유저를 저장
    User.create(
      user_key: user_key, chat_room: 0
    )
    render nothing: true
  end
  
  def friend_del
    # 유저 삭제
    user = User.find_by(user_key: params[:user_key])
    user.destroy
    render nothing: true
  end
  
  def chat_room
    # chat_room = 0 에서 +1 씩  추가
    user = User.find_by(user_key: params[:user_key])
    user.plus
    user.save
    render nothing: true
  end
  
end
