class UserMailer < ApplicationMailer
  def fefo_mail(plant,str_loc,date,reason,sap_batch,expiry_dt)
    @plant = plant
    @str_loc = str_loc
    @date = date
    @reason = reason
    @sap_batch = sap_batch
    @expiry_dt = expiry_dt
    mail(to: 'ramprasath.p@tvstyres.com', subject: 'Sample Email', content_type: 'text/html', :template_path => 'user_mailer',
          :template_name => 'fefo_mail_html.erb'.html_safe)
    end
end
