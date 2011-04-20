module ApplicationHelper
  
  def user_is_admin?
    false
  end
  
  def login_link
    "GREETING"
    # if user:
    #     greeting = users.create_logout_url("/")
    # else:
    #     greeting = users.create_login_url("/")
  end
  
  def title
    "Rails Stashboard"
  end
  
  def user
    nil
  end
  
  def start_date
    nil
  end
        
  def common_statuses
    [
      [
          "tick-circle",
          "cross-circle",
          "exclamation",
          "wrench",
          "flag",
      ],
      [
          "clock",
          "heart",
          "hard-hat",
          "information",
          "lock",
      ],
      [
          "plug",
          "question",
          "traffic-cone",
          "bug",
          "broom",
      ],
    ]
  end
    
end
