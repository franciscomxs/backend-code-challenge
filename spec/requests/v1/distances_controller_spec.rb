require 'rails_helper'

RSpec.describe V1::DistancesController, type: :request do
  describe "POST 'create'" do
    context 'with valid params' do
      before do
        post v1_distance_path, params
      end

      let(:params) { { distance: {
        origin: 'Konohagakure',
        destination: 'Amegakure',
        distance: '1000'
      } } }

      it 'has a success response' do
        expect(last_response.status).to eq(201)
        expect(json[:origin]).to eq('Konohagakure')
        expect(json[:destination]).to eq('Amegakure')
        expect(json[:distance]).to eq(1000)
      end
    end

    context 'with repeated valid params' do
      let!(:distance) { create(:distance,
        origin: 'Konohagakure',
        destination: 'Amegakure',
        distance: '1000')
      }

      let(:params) { { distance: {
        origin: 'Konohagakure',
        destination: 'Amegakure',
        distance: '2000'
      } } }

      it 'do not create duplicated records' do
        expect do
          post v1_distance_path, params
        end.to_not change(Distance, :count)
      end

      it 'update values instead duplicate records' do
        expect do
          post v1_distance_path, params
        end.to change { Distance.last.distance }.from(1000).to(2000)
      end
    end

    context 'with invalid params' do
      before do
        post v1_distance_path, params
      end

      context 'with empty params' do
        let(:params) { { } }

        it 'responds with Unprecessable Entity' do
          expect(last_response.status).to eq(400)
        end
      end

      context 'params with empty attributes' do
        let(:params) { { distance: {
          origin: '',
          destination: '',
          distance: ''
        } } }

        it 'has a Unprecessable Entity response' do
          expect(last_response.status).to eq(422)
          expect(json[:errors]).to match_array([
            "Origin can't be blank",
            "Destination can't be blank",
            "Distance can't be blank",
            "Distance is not a number"]
          )
        end
      end
    end
  end
end
