require 'rails_helper'

RSpec.describe StaticController, type: :controller do

  describe "GET #pages" do
    it "returns http success" do
      get :pages
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #home" do
    it "returns http success" do
      get :home
      expect(response).to have_http_status(:success)
    end
  end

end
