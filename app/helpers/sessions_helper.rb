module SessionsHelper

  #Logs in the given user
  def log_in(user)
    session[:user_id] = user.id #tworzy encrypted temp cookies
  end

  def remember(user)
    user.remember # z klasy User(.rb) metoda remember
    cookies.permanent.signed[:user_id] = user.id # to jest niezabezpieczone ale jak dopisze sie signed
    cookies.permanent[:remember_token] = user.remember_token
    # to samo co wyzej^ => session[:user_id] = { value: user.id, expires: 20.years.from_now.utc } #tworzy encrypted temp cookies
  end

  #Returns the current logged-in user
  def current_user
    #@current_user = @current_user || User.find_by(id: session[:user_id]) to samo nizej
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id]) # gdy seesja jest zakonczona(zamknieta przegladarka) to przestaje dzialac
    elsif cookies.permanent.signed[:user_id]
      user = User.find_by(id: cookies.signed[:user_id])
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  #Returns true if the user is logged, false otherwise

  def logged_in?
    !current_user.nil?
  end

  #Logs out the current user
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
