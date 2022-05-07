def rtl_if_heb 
	is_heb ? 'rtl' : 'ltr'
end

def text_align_right_if_heb 
	is_heb ? 'text_align_right' : ''
end

def to_heb(eng, heb)
	is_heb ? heb : eng
end