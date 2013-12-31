if user_account_signed_in?
	json.user_account do
		json.extract! current_user_account, :id, :first_name, :last_name, :username
	end
else
	{}
end