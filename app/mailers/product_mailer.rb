class ProductMailer < ApplicationMailer
  def product_info
    @product = params[:product]
    @user = params[:user]

    mail(to: 'menkesaskia@web.de', subject: 'Your requested product information')
  end
end
