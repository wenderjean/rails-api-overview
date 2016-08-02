require 'rails_helper'

RSpec.describe "Patients", type: :request do

  describe "GET /patients" do
    before(:each) do
      @patient_1 = create(:patient, :name => "Patient 1")
      @patient_2 = create(:patient, :name => "Patient 2")
      get patients_path
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "all patients should be returned" do
      expect(JSON.parse(response.body)).to eq([YAML.load(@patient_1.to_json), YAML.load(@patient_2.to_json)])
    end
  end

  describe "POST /patients" do
    context "when valid params" do
      before(:each) do
        post patients_path, :params => { patient: attributes_for(:patient) }
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

  describe "PUT /patients/:id" do
    subject { create(:patient) }
    let(:new_name) { "Wender Freese" }

    context "when created" do
      it "patient name should be Patient" do
        expect(subject.name).to eq("Patient")
      end
    end

    context "after update" do
      before(:each) do
        put "/patients/#{subject.id}", params: { patient: attributes_for(:patient, :name => new_name) }
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "name has changed" do
        expect(Patient.find_by_id(subject.id).name).to eq(new_name)
      end
    end
  end

  describe "DELETE /patient/:id" do
    before(:each) do
      @patient = create(:patient)
      delete "/patients/#{@patient.id}"
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "patient should not exists" do
      expect(Patient.find_by_id(@patient.id)).to be_nil
    end
  end
end
