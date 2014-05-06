require 'spec_helper'

describe OmniAuth::Strategies::Firmafon do

  let(:request) { double('Request', :params => {}, :cookies => {}, :env => {}) }
	let(:app) { lambda { |*args| [200, {}, ["Hello"]] } }

	subject do
		OmniAuth::Strategies::Firmafon.new(app, 'appid', 'secret', @options || {}).tap do |strategy|
			allow(strategy).to receive(:request) { request }
		end
	end

	before do
		OmniAuth.config.test_mode = true
	end

	after do
		OmniAuth.config.test_mode = false
	end

	describe '#client_options' do
		it 'has correct site' do
			expect(subject.client.site).to eq('https://app.firmafon.dk')
		end

		it 'has correct authorize_url' do
			expect(subject.client.options[:authorize_url]).to eq('/api/v2/authorize')
		end

		it 'has correct token_url' do
			expect(subject.client.options[:token_url]).to eq('/api/v2/token')
		end
	end

	describe "#callback_path" do
		it 'has the correct callback path' do
			subject.callback_path.should eq('/auth/firmafon/callback')
		end
	end

	describe "#uid" do
		before do
			subject.stub(:raw_info) { { 'id' => 1 } }
		end
		it "is the id" do
			expect(subject.uid).to eq(1)
		end
	end

	describe "#info" do
		before do
			subject.stub(:raw_info) { {'id' => 1, 'name' => 'Karsten Kollega' } }
		end
		it "is the id" do
			expect(subject.info).to eq({:id => 1, :name => 'Karsten Kollega' })
		end
	end

	describe "#extra" do
		before do
			subject.stub(:raw_info) { { :foo => 'bar' } }
		end
		it { subject.extra.should eq({ :foo => 'bar'}) }
	end

	describe "#credentials" do
		before do
			@access_token = double('OAuth2::AccessToken').as_null_object
			subject.stub(:access_token) { @access_token }
		end

		it 'returns the token' do
			@access_token.stub(:token) { '123' }
			subject.credentials['token'].should eq('123')
		end
	end

end

