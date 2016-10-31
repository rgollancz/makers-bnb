describe User do
  subject(:user) { described_class.new }

  context "User setup" do
    it { is_expected.to have_property :id }
    it { is_expected.to have_property :name }
    it { is_expected.to have_property :email }
    it { is_expected.to have_property :created_at }
    it { is_expected.to have_property :phone_number }
    it { is_expected.to have_property :bio }
    it { is_expected.to have_property :encrypted_password }
end

end
