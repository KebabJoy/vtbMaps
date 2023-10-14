# frozen_string_literal: true

module DepartmentsContext
  class Atm < ApplicationRecord
    class ServiceAvailability
      include StoreModel::Model

      attribute :service_activity, :string
      attribute :service_capability, :string
    end

    class Service
      include StoreModel::Model

      attribute :wheelchair, ServiceAvailability.to_type
      attribute :blind, ServiceAvailability.to_type
      attribute :nfc_for_bank_cards, ServiceAvailability.to_type
      attribute :qr_read, ServiceAvailability.to_type
      attribute :supports_usd, ServiceAvailability.to_type
      attribute :supports_charge_rub, ServiceAvailability.to_type
      attribute :supports_eur, ServiceAvailability.to_type
      attribute :supports_rub, ServiceAvailability.to_type
    end

    has_one :address, as: :target, class_name: "DepartmentsContext::Address", dependent: :destroy

    accepts_nested_attributes_for :address

    attribute :services, Service.to_type
  end
end
