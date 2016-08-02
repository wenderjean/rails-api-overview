require 'rails_helper'

RSpec.describe "Patients", type: :request do

  let(:name) { "Wender Freese" }

  describe "GET /patients" do
    it "all patients should be returned" do
      get patients_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /patients" do
    context "when valid params" do
      before(:each) do
        post patients_path, :params => { patient: { name: name } }
      end

      it "returns http created status" do
        expect(response).to have_http_status(:created)
      end

      it "should create patient" do
        expect change(Patient, :count).by(1)
      end
    end

    context "when invalid params" do
      it "return http unprocessable status" do
        post patients_path, :params => { patient: { name: "" } }
        expect(response).to have_http_status(422)
      end
    end
  end

  describe "PUT /patients" do

  end

  describe "DELETE /patient/:id" do

  end
end
