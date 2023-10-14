class ApplicationController < ActionController::Base
  def unsafe_params
    params.to_unsafe_hash.deep_symbolize_keys
  end
end
