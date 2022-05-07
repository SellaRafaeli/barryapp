# who, what, where, when, why, how

def interjection
	interjection = ['aha', 'ahem', 'ahh', 'ahoy', 'alas', 'arg', 'aw''bam', 'bingo', 'blah', 'boo', 'bravo', 'brrr', 'cheers', 'congratulations','dang', 'drat', 'darn', 'duh','eek', 'eh', 'encore', 'eureka', 'fiddlesticks', 'gadzooks', 'gee', 'gee' 'whiz', 'golly', 'goodbye', 'goodness', 'good', 'grief', 'gosh', 'ha-ha', 'hallelujah', 'hello', 'hey', 'hmm', 'holy' 'buckets', 'holy cow', 'holy' 'smokes', 'hot' 'dog', 'huh',  'hurray','oh', 'oh dear', 'oh my', 'oh' 'well', 'oops', 'ouch', 'ow', 'phew', 'phooey', 'pooh', 'pow''rats''shh', 'shoo','thanks', 'there', 'tut-tut','uh-huh', 'uh-oh', 'ugh','wahoo', 'well', 'whoa', 'whoops', 'wow','yeah', 'yes', 'yikes', 'yippee', 'yo', 'yuck',
		'thank God','thank Heavens','praise the Lord','God bless','Heaven bless','bless their heart','so happy', 'fantastic','great stuff','good stuff','good weed!',
		'beautiful','nice','amazing','jubilant','terrific','top-notch','first-class','lovely',
		'my favorite','delicious','sweet','hazy',"You'll love it",
		'6/10','7/10','8/10','9/10','10/10','perfect','perfection','good shit','excellent','great','good','quality','nice','sensitive',
	].sample+['! ','!! ','!!! ', '... ','. ',' '].sample
end

def opener
	first  = gen_adjective + ' ' + gen_noun+', '+interjection
	second = interjection+ ' '+gen_adjective + ' ' + gen_noun+['.','!','!!','...'].sample
	third  = gen_adjective + ', ' + gen_adjective + ' ' + gen_noun + ' and ' + gen_noun + ['.','!','...'].sample
	fourth = gen_noun+': '+gen_adjective+'. '
	fifth  = 'if you '+['want','are looking for','are searching for','desire'].sample+ ' ' + gen_adjective+ ' ' +gen_noun + [' -- ',',',';',' then '].sample+' ' + ['great','you found it','good job','success','hooray','congratulations', 'then yes sir'].sample
	six    = interjection+', '+interjection+' '+gen_adjective+ ' '+ gen_noun
	[first,second,third,fourth,fifth,six].sample
end

def small_sentence
	['it','the '+gen_noun].sample + ' was '+gen_adverb+' '+[gen_adjective,gen_feeling].sample
end

def future_sentence
	['next time','in the future','next week','tomorrow','next year, ','will','might','will not',"won't",'will definitely','not sure if I',"can't say if I will"].sample+ ' '+
	['try again.','order again','visit again','do this again','reconsider','recommend','approve','rate high','revisit.'].sample
end

def gen_noun
	['price', 'effect', 'delivery', 'support', 'size', 'customer service', 'taste', 'feeling', 'product', 'satisfaction','weed','cannabis','material','experience','dish','hash','edibles','smell','reaction','high','trip',
		'green', 'hash', 'pot', 'weed', 'dank', 'reefer', 'Mary Jane', 'chronic', 'nug', 'bud', 'herb', 'flower', 'skunk', 'dope', 'hay', 'blaze', 'boom', 'rope',
		'atmosphere','cannabis','cannabis','cannabis','bong',
		'weed','high','flower','hash','resin','tincture','mints',
		'customer support',
	].sample 	
end

def gen_adverb
	['Abnormally', 'Abruptly', 'Absently', 'Accidentally', 'Accusingly', 'Actually', 'Adventurously', 'Adversely', 'Afterwards', 'Almost', 'Always', 'Amazingly', 'Angrily', 'Anxiously', 'Arrogantly', 'Awkwardly', 'Badly', 'Bashfully', 'Beautifully', 'Bitterly', 'Bleakly', 'Blindly', 'Blissfully', 'Boldly', 'Bravely', 'Briefly', 'Brightly', 'Briskly', 'Broadly', 'Busily', 'Calmly', 'Carefully', 'Carelessly', 'Cautiously', 'Certainly', 'Cheerfully', 'Clearly', 'Cleverly', 'Closely', 'Coaxingly', 'Commonly', 'Continually', 'Coolly', 'Correctly', 'Courageously', 'Crossly', 'Cruelly', 'Curiously', 'Daily', 'Daintily', 'Daringly', 'Dearly', 'Deceivingly', 'Deeply', 'Deliberately', 'Delightfully', 'Desperately', 'Determinedly', 'Diligently', 'Doubtfully', 'Dreamily', 'Eagerly', 'Easily', 'Elegantly', 'Energetically', 'Enormously', 'Equally', 'Especially', 'Even', 'Eventually', 'Exactly', 'Excitedly', 'Extremely', 'Fairly', 'Famously', 'Far', 'Fast', 'Fatally', 'Ferociously', 'Fervently', 'Fiercely', 'Fondly', 'Foolishly', 'Fortunately', 'Frankly', 'Frantically', 'Freely', 'Frightfully', 'Fully', 'Furiously', 'Generally', 'Generously', 'Gently', 'Gladly', 'Gracefully', 'Gratefully', 'Greatly', 'Greedily', 'Happily', 'Hard', 'Harshly', 'Hastily', 'Heartily', 'Heavily', 'Helpfully', 'Helplessly', 'Here', 'Highly', 'Honestly', 'Hopelessly', 'Hungrily', 'Hurriedly', 'Immediately', 'Inadequately', 'Increasingly', 'Innocently', 'Inquisitively', 'Instantly', 'Intensely', 'Interestingly', 'Inwardly', 'Irritably', 'Jealously', 'Jovially', 'Joyfully', 'Joyously', 'Jubilantly', 'Justly', 'Keenly', 'Kiddingly', 'Kindly', 'Knavishly', 'Knowingly', 'Knowledgeably', 'Lazily', 'Less', 'Lightly', 'Likely', 'Lively', 'Loftily', 'Longingly', 'Loosely', 'Loudly', 'Lovingly', 'Loyally', 'Madly', 'Majestically', 'Meaningfully', 'Mechanically', 'Merrily', 'Miserably', 'Mockingly', 'More', 'Mortally', 'Mysteriously', 'Naturally', 'Nearly', 'Nervously', 'Never', 'Nicely', 'Noisily', 'Obediently', 'Oddly', 'Offensively', 'Officially', 'Only', 'Openly', 'Optimistically', 'Painfully', 'Patiently', 'Perfectly', 'Physically', 'Playfully', 'Politely', 'Poorly', 'Potentially', 'Powerfully', 'Promptly', 'Properly', 'Proudly', 'Punctually', 'Quaintly', 'Queerly', 'Questionably', 'Quicker', 'Quickly', 'Quietly', 'Quirkily', 'Quizzically', 'Rapidly', 'Rarely', 'Ravenously', 'Readily', 'Really', 'Reassuringly', 'Recklessly', 'Regularly', 'Reluctantly', 'Repeatedly', 'Restfully', 'Righteously', 'Rightfully', 'Roughly', 'Rudely', 'Sadly', 'Safely', 'Scarcely', 'Searchingly', 'Seemingly', 'Seldom', 'Selfishly', 'Seriously', 'Shakily', 'Sharply', 'Sheepishly', 'Shrilly', 'Shyly', 'Silently', 'Sleepily', 'Slowly', 'Smoothly', 'Softly', 'Solemnly', 'Sometimes', 'Soon', 'Speedily', 'Stealthily', 'Sternly', 'Strictly', 'Stubbornly', 'Stupidly', 'Suddenly', 'Supposedly', 'Surprisingly', 'Suspiciously', 'Sweetly', 'Swiftly', 'Sympathetically', 'Tensely', 'Terribly', 'Thankfully', 'Thoroughly', 'Thoughtfully', 'Tightly', 'Tomorrow', 'Tonight', 'Too', 'Tremendously', 'Truly', 'Truthfully', 'Ultimately', 'Unaccountably', 'Unbearably', 'Understandingly', 'Unexpectedly', 'Unfortunately', 'Unhappily', 'Unnecessarily', 'Unwillingly', 'Upbeat', 'Upright', 'Upward', 'Urgently', 'Usefully', 'Uselessly', 'Usually', 'Vacantly', 'Vaguely', 'Vainly', 'Valiantly', 'Vastly', 'Verbally', 'Viciously', 'Victoriously', 'Violently', 'Vivaciously', 'Voluntarily', 'Warmly', 'Wearily', 'Well', 'Wetly', 'Wholly', 'Wildly', 'Wisely', 'Wonderfully', 'Wrongly', 'Yearly', 'Youthfully'].sample.downcase
end

def gen_adjective
	(['good','bad','low','high',"dorable", "adventurous", "aggressive", "agreeable", "alert", "alive", "amused", "angry", "annoyed", "annoying", "anxious", "arrogant", "ashamed", "attractive", "average", "awful", "bad", "beautiful", "better", "bewildered", "black", "bloody", "blue", "blue-eyed", "blushing", "bored", "brainy", "brave", "breakable", "bright", "busy", "calm", "careful", "cautious", "charming", "cheerful", "clean", "clear", "clever", "cloudy", "clumsy", "colorful", "combative", "comfortable", "concerned", "condemned", "confused", "cooperative", "courageous", "crazy", "creepy", "crowded", "cruel", "curious", "cute", "dangerous", "dark", "dead", "defeated", "defiant", "delightful", "depressed", "determined", "different", "difficult", "disgusted", "distinct", "disturbed", "dizzy", "doubtful", "drab", "dull"] + 
		["eager", "easy", "elated", "elegant", "embarrassed", "enchanting", "encouraging", "energetic", "enthusiastic", "envious", "evil", "excited", "expensive", "exuberant", "fair", "faithful", "famous", "fancy", "fantastic", "fierce", "filthy", "fine", "foolish", "fragile", "frail", "frantic", "friendly", "frightened", "funny", "gentle", "gifted", "glamorous", "gleaming", "glorious", "good", "gorgeous", "graceful", "grieving", "grotesque", "grumpy", "handsome", "happy", "healthy", "helpful", "helpless", "hilarious", "homeless", "homely", "horrible", "hungry", "hurt", "ill", "important", "impossible", "inexpensive", "innocent", "inquisitive", "itchy", "jealous", "jittery", "jolly", "joyous", "kind", "lazy", "light", "lively", "lonely", "long", "lovely", "lucky", "magnificent", "misty", "modern", "motionless", "muddy", "mushy", "mysterious", "nasty", "naughty", "nervous", "nice", "nutty", "obedient", "obnoxious", "odd", "old-fashioned", "open", "outrageous", "outstanding", "panicky", "perfect", "plain", "pleasant", "poised", "poor", "powerful", "precious", "prickly", "proud", "putrid", "puzzled", "quaint", "real", "relieved", "repulsive", "rich", "scary", "selfish", "shiny", "shy", "silly", "sleepy", "smiling", "smoggy", "sore", "sparkling", "splendid", "spotless", "stormy", "strange", "stupid", "successful", "super", "talented", "tame", "tasty", "tender", "tense", "terrible", "thankful", "thoughtful", "thoughtless", "tired", "tough", "troubled", "ugliest", "ugly", "uninterested", "unsightly", "unusual", "upset", "uptight", "vast", "victorious", "vivacious", "wandering", "weary", "wicked", "wide-eyed", "wild", "witty", "worried", "worrisome", "wrong", "zany", "zealous"]).sample
end

def rand_time 
	['on','this','last','every','next','before','during','the last time on','the first time on','last time on','sometime on','once on','I remember on'].sample + ' '+
	['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'].sample
end

def gen_feeling
	['OPEN', 'HAPPY', 'ALIVE', 'GOOD', 'understanding', 'great', 'playful', 'calm', 'confident', 'gay', 'courageous', 'peaceful', 'reliable', 'joyous', 'energetic', 'aease', 'easy', 'lucky', 'liberated', 'comfortable', 'amazed', 'fortunate', 'optimistic', 'pleased', 'free', 'delighted', 'provocative', 'encouraged', 'sympathetic', 'overjoyed', 'impulsive', 'clever', 'interested', 'gleeful', 'surprised', 'satisfied', 'thankful', 'frisky', 'content', 'receptive', 'important', 'animated', 'quiet', 'accepting', 'festive', 'spirited', 'certain', 'kind', 'ecstatic', 'thrilled', 'relaxed', 'satisfied', 'wonderful', 'serene', 'glad', 'free and easy', 'cheerful', 'bright', 'sunny', 'blessed', 'merry', 'reassured', 'elated', 'jubilant', 'LOVE', 'INTERESTED', 'POSITIVE', 'STRONG', 'loving', 'concerned', 'eager', 'impulsive', 'considerate', 'affected', 'keen', 'free', 'affectionate', 'fascinated', 'earnest', 'sure', 'sensitive', 'intrigued', 'intent', 'certain', 'tender', 'absorbed', 'anxious', 'rebellious', 'devoted', 'inquisitive', 'inspired', 'unique', 'attracted', 'nosy', 'determined', 'dynamic', 'passionate', 'snoopy', 'excited', 'tenacious', 'admiration', 'engrossed', 'enthusiastic', 'hardy', 'warm', 'curious', 'bold', 'secure', 'touched', 'brave', 'sympathy', 'daring', 'close', 'challenged', 'loved', 'optimistic', 'comforted', 're-enforced', 'drawn toward', 'confident', 'hopeful'].sample
end

def gen_phrase(opts = {})
	pre_prenoun = ['well,','this time,','today ','yesterday','last night',rand_time, rand_time, rand_time].sample
	prenoun  =  pre_prenoun+' '+['I','we','my friends','my friends and I','my husband','my wife','my husband and I','my wife and I','my family','our friends'].sample 
	
	# prenoun.downcase! unless opts[:first]
	
	adverb    = gen_adverb

	verb      = ['thought','decided','discovered','enjoyed', 'hated','tried','felt','smoked','consumed','relished','had', 'were', 'was','cut','found','suggested','sampled','loved','was surprised by','devoured','ran through','exemplified'].sample
	
	verb      = [adverb+ ' '+verb,verb,verb,verb+' '+adverb].sample

	noun      = gen_noun
	
	filler    = ['really', 'quite', 'very','totally','actually','indeed','somewhat'].sample
	adjective = gen_adjective

	feeling  = gen_feeling

	last = opts[:last]

	afternoun = ['; it',', it','-- and it','-and it',' but they',' because it',' and it',' but it',' and while it',', and although it',';','.','...','..'].sample
	
	curr = "#{prenoun} #{verb} the #{noun}#{afternoun} was #{adjective}, #{['','','',' '+interjection].sample} #{[adjective,feeling].sample} "

	curr = [interjection+curr, curr+interjection].sample

	curr = [opener,opener,opener + ' ' + curr,curr,curr,curr,small_sentence,future_sentence].sample 

	curr = curr.squish
	curr.gsub!(' .','.')
	curr.gsub!(' ,',',')
	curr.gsub!(' ;',';')
	curr.gsub!('  ',' ')
	curr.gsub!('.,','.')
	curr.gsub!('!.','!')

	#capitalize first letters 

	curr.gsub!(/([a-z])((?:[^.?!]|\.(?=[a-z]))*)/i) { $1.upcase + $2.rstrip }

	if last 
		return curr+"."
	else 
		# puts "going in"
		connector = [', however,',', but',', and yet,',', on the other hand',' and','. Now,',' and yes,',', but in contrast,',' and this seemed '].sample
		return (curr+connector+' ')+gen_phrase({last: [true,false,false].sample})
	end
end

def add_generated_review(seller_id)
	puts "adding generated review for #{seller_id}: "
	text   = gen_phrase(first: true)
	rating = [3,4,4,4,4,4,5,5,5,5].sample.to_s
	reviewer_name = $female_names.sample+ ' ' + ('A'..'Z').to_a.sample+'.'
	data = {seller_id: seller_id, text: text, rating: rating, buyer_id: nil, generator_version: 1, reviewer_name: reviewer_name, reviewer_img_url: random_profile_pic_img, force_created_at: rand(100).days.ago}
	$reviews.add(data)
	# puts "added:\r\n#{text}"
end

# $users.all(csv: true).each_with_index {|u,idx| puts idx.to_s.yellow; [2,3,4].sample.times { add_generated_review(u[:_id])} }
# gen_phrase(first: true)