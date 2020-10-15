module Enroll::EnrollmentsCoupons
  def coupon_available
    json_response_body[:available]
  end

  def coupon_discount_rate
    json_response_body_promotion[:discount_rate]
  end

  def coupon_promotion_name
    json_response_body_promotion[:name]
  end

  def coupon_expiration_date
    json_response_body_promotion[:expire_date_formatted]
  end

  private

  def json_response
    @json_response ||= VerifyCouponService.new(self.coupon).call
  end

  def json_response_body
    @json_response_body = JSON.parse(json_response.body, symbolize_names: true)
  end

  def json_response_body_promotion
    json_response_body[:promotion]
  end
end
