require 'gmail_xoauth'
require 'gmail'
require 'google/apis/gmail_v1'
require 'googleauth'
require 'googleauth/stores/file_token_store'
require 'mail'


   class GmailAccess
       def initialize(email,oauth_token)
          begin
             @imap = Net::IMAP.new('imap.googlemail.com', 993, usessl = true, certs = nil, verify = false)
             @imap.authenticate('XOAUTH2',email,oauth_token)
             @imap
          rescue Exception => e
            return "Error in Auth Token or email: #{e}"
         end
       end

       def display_message_id
            @imap.select("[Gmail]/All Mail")
            all_mail_id = @imap.search(["ALL"])
            all_mail_id
       end

       def total_message_count
          xmessages_count = @imap.status('INBOX', ['MESSAGES'])['MESSAGES']
          xmessages_count
      end

      def search(text, type='body',mailbox='all')
          message_id = []
          hash = {subject: 'SUBJECT', to: 'TO', from: 'FROM', cc: 'CC' , body: 'BODY'}
          mail_box = { inbox: 'INBOX', all: '[Gmail]/All Mail', draft: '[Gmail]/Drafts',
                       important:'[Gmail]/Important', sent: '[Gmail]/Sent Mail',
                       spam: '[Gmail]/Spam',trash: '[Gmail]/Trash', starred: '[Gmail]/Starred' }
                      @imap.select(mail_box[mailbox.downcase.to_sym])
          message_id = @imap.search([hash[type.downcase.to_sym], text, "NOT", "NEW" ])
          message_id
      end

      def fetch_user_id

      end
      def disconnect
        @imap.disconnect
        return("Successfully disconnect!!")
      end

      def message_body( message_ids = [])
          envelope = {}
          i = 0
          count = 0
          while(message_ids.count > count)
                  tmp = []
                  tmp[i=0]=@imap.fetch(message_ids[count], 'BODY[HEADER.FIELDS (SUBJECT)]').to_s.split("{").second.chop
                  tmp[i+=1]=@imap.fetch(message_ids[count], 'BODY[HEADER.FIELDS (FROM)]').to_s.split("{").second.chop
                  tmp[i+=1]=@imap.fetch(message_ids[count], 'BODY[HEADER.FIELDS (to)]').to_s.split("{").second.chop
                  tmp[i+=1]=@imap.fetch(message_ids[count], 'BODY[HEADER.FIELDS (BCC)]').to_s.split("{").second.chop
                  tmp[i+=1]=@imap.fetch(message_ids[count], 'BODY[HEADER.FIELDS (CC)]').to_s.split("{").second.chop
                  tmp[i+=1]=@imap.fetch(message_ids[count], 'BODY[HEADER.FIELDS (BODY)]').to_s.split("{").second.chop
                  envelope[message_ids[count]] = tmp
                 count += 1
          end
          envelope
      end
   end
