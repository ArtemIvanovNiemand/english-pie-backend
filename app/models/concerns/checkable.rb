module Checkable
  extend ActiveSupport::Concern

  def check(user_answer)
    user_answer == answer
  end
end
