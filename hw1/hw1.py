import re
import csv
import sys

# Start csvwriter for ebook.csv
with open('ebook.csv', 'w') as ebooksfile:
	fieldnames = ['title', 'author', 'release_date', 'ebook_id', 'language', 'body']
	ebook_writer = csv.DictWriter(ebooksfile, fieldnames=fieldnames)
	ebook_writer.writeheader()

	# Start csvwriter for tokens.csv
	with open('tokens.csv', 'w') as tokensfile:
		fieldnames = ['ebook_id', 'token']
		token_writer = csv.DictWriter(tokensfile, fieldnames=fieldnames)
		token_writer.writeheader()
		
		# Set all fields to null
		body_list = []
		in_body_flag = False
		is_author_done = False
		title = "null"
		author = "null"
		release_date = "null"
		ebook_id = "null"
		language = "null"
		body = "null"

		# Read line by line the input 
		for line in sys.stdin:
			if "*** END OF THE PROJECT GUTENBERG" in line:
				in_body_flag = False
				body = ''.join(body_list)

				# Begin tokenizing on the body, first by seperating the body into an array of tokens
				tokenize = re.findall("[a-zA-Z]+", body.lower())
				# Run through the tokenized array and write to tokens.csv
				for token in tokenize:
					token_writer.writerow({'ebook_id': ebook_id, 'token':token})

				# Write to ebook.csv
				ebook_writer.writerow({'title': title, 'author': author, 'release_date': release_date, 'ebook_id': ebook_id, 'language': language, 'body': body})
				
				# Reset all fields to null
				body_list = [] 
				in_body_flag = False
				title = "null"
				author = "null"
				release_date = "null"
				ebook_id = "null"
				language = "null"
				is_author_done = False
				body = "null"
				continue

			if "*** START OF THE PROJECT GUTENBERG" in line:
				in_body_flag = True
				continue

			if in_body_flag:
				body_list.append(line)
				continue
				
			else:
				if line.startswith("Title:"):
					x = line.index("Title: ") + 7
					title = line[x:].strip()
					continue

				if line.startswith("Author:") and not is_author_done: 
					x = line.index("Author: ") + 8
					author = line[x:].strip()
					is_author_done = True
					continue

				if line.startswith("Release Date:"):						
					x = line.index("Release Date: ") + 14
					y = line.index('[')
					release_date = line[x:y].strip()
					y = line.index('#')+1
					z = line.index(']')
					ebook_id = line[y:z].strip()						
					continue

				if line.startswith("Language:"):
					x = line.index("Language: ") + 10
					language = line[x:].strip()
					continue