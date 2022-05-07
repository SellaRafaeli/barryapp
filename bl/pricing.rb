#NOWCAST_PRO = 'nowcast_pro'

NOWCAST_PRO = 'NOWCAST_PRO'

def get_nowcast_pro_cast
	$casts.get(tags: NOWCAST_PRO)
end

def is_pro(user = cu)
	#return false
	#return true if !$prod
	user && user[NOWCAST_PRO]
end