class PaidUp::Plan < ActiveRecord::Base
  has_many :features_plans, class_name: 'PaidUp::FeaturesPlan'
  has_many :features, :through => :features_plans, class_name: 'PaidUp::Feature'

  validates_presence_of :description, :name

  after_find :load_stripe_data
  after_create :load_stripe_data

  attr_accessor :stripe_data

  default_scope { order('sort_order ASC') }
  scope :free, -> { where(stripe_id: PaidUp.configuration.free_plan_stripe_id).first }
  scope :subscribable, -> { where('sort_order >=  ?', 0) }

  def feature_setting(name)
    feature = PaidUp::Feature.find_by_name(name)
    raw = features_plans.find_by_feature_name(name)
    if raw.nil?
      if feature.setting_type == 'boolean'
        false
      else
        0
      end
    else
      if feature.setting_type == 'boolean'
        if raw.setting > 0 || raw.setting == -1
          true
        else
          false
        end
      else
        raw.setting
      end
    end
  end

  def feature_unlimited?(name)
    feature_setting(name) == -1
  end

  def interval
    if stripe_data.present?
      stripe_data.interval
    else
      :default_interval.l
    end
  end

  def interval_count
    if stripe_data.present?
      stripe_data.interval_count
    else
      1
    end
  end

  def amount
    if stripe_data.present?
      stripe_data.amount
    else
      0
    end
  end

  def money
    Money.new(amount, currency)
  end

  def charge
    money.amount
  end

  def currency
    if stripe_data.present?
      stripe_data.currency.upcase
    else
      :default_currency.l.upcase
    end
  end

  private

  def load_stripe_data
    if stripe_id.present?
      self.stripe_data = Stripe::Plan.retrieve stripe_id
    end
  end

end