require 'rails_helper'

RSpec.describe V1::CostsController, type: :request do
  describe "GET 'show'" do
    before do
      [['A', 'B', 7],
      ['A', 'C', 9],
      ['A', 'F', 14],
      ['B', 'C', 10],
      ['B', 'D', 15],
      ['C', 'D', 11],
      ['C', 'F', 2],
      ['D', 'E', 6],
      ['E', 'F', 9]].each do |edge|
        origin, destination, distance = *edge

        create(:distance, origin: origin, destination: destination,
          distance: distance)
      end
    end

    context 'with valid params' do
      before do
        get v1_cost_path, params
      end

      let(:params) { {
        origin: 'A',
        destination: 'E',
        weight: '10'
      } }

      it 'has a success response' do
        expect(last_response.status).to eq(200)
        expect(json[:shortest_route]).to eq('A - C - F - E')
        # distance: 20, weight: 10
        # 20 * 10 * 0.15 = 30
        expect(json[:cost]).to eq(30)
      end
    end

    context 'with invalid params' do
      before do
        get v1_cost_path, params
      end

      context 'with empty params' do
        let(:params) { {
          origin: 'A',
          destination: 'G',
          weight: '10'
        } }

        it 'responds with Unprecessable Entity' do
          expect(last_response.status).to eq(422)
          expect(json[:errors]).to match_array(['Invalid route'])
        end
      end

      context 'params with empty attributes' do
        let(:params) { { } }

        it 'has a Unprecessable Entity response' do
          expect(last_response.status).to eq(422)
          expect(json[:errors]).to match_array([
            "Destination can't be blank",
            "Invalid route",
            "Origin can't be blank",
            "Weight can't be blank",
            "Weight is not a number"
          ])
        end
      end
    end
  end
end
