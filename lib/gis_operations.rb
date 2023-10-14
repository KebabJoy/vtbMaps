# frozen_string_literal: true

module GisOperations
  module_function

  # More at https://en.wikipedia.org/wiki/Spatial_reference_system
  APPLICATION_SRID = 4326

  def factory
    RGeo::Geographic.spherical_factory(srid: APPLICATION_SRID)
  end

  def to_rgeo_point(lat, lon)
    factory.point(lon, lat)
  end

  def hash_to_point(coords_hash)
    return unless coords_hash.is_a?(Hash)

    coords = coords_hash.symbolize_keys
    return if coords[:lat].blank? || (coords[:lng].blank? && coords[:lon].blank?)

    to_rgeo_point(coords[:lat], (coords[:lng] || coords[:lon]))
  end

  def point_to_hash(rgeo_point)
    {lat: rgeo_point.lat, lon: rgeo_point.lon}
  end

  # @param a [RGeo::Geographic::SphericalPointImpl] Точка А
  # @param b [RGeo::Geographic::SphericalPointImpl] Точка Б
  # @return [Float] Расстояние между точками, в метрах
  def self.distance_between_points(a:, b:)
    a.distance(b)
  end
end
