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

  # Returns true if the given user is the current user.
  def current_user?(user)
    user == current_user
  end

  #Returns the current logged-in user
  def current_user
    #@current_user = @current_user || User.find_by(id: session[:user_id]) to samo nizej
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: session[:user_id]) # gdy seesja jest zakonczona(zamknieta przegladarka) to przestaje dzialac
    elsif (user_id = cookies.signed[:user_id])
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

  #Forgets a persisten session
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)

  end

  #Logs out the current user
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  # Redirects to stored location (or the default)
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # Stores the URL trying to be accessed
  def store_location
    session[:forwarding_url] = request.url if request.get?
  end
end
