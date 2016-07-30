require 'rails_helper'

RSpec.describe PatientsController, type: :controller do

  let(:valid_attributes) {
    { name: "Wender Freese" }
  }

  describe "POST create" do
    describe "with valid params" do
      it "returns https success" do
        post :create, { :patient => valid_attributes }
        expect(response.content_type).to eq "application/json"
        expect(response).to have_http_status(:created)
      end

      it "should create patient" do
        expect { post :create, { :patient => valid_attributes } }.to change(Patient, :count).by(1)
      end
    end
  end
end
