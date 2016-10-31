describe Space do
  subject(:space) { described_class.new }

  context "Space setup" do
    it { is_expected.to have_property :id }
    it { is_expected.to have_property :name }
    it { is_expected.to have_property :description }
    it { is_expected.to have_property :price }
    it { is_expected.to have_property :address }
  end
end
