# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
tag_types = TagType.create([
	{
		name: 'City',
		radius: 10000.0,
		description: 'Medium- to large-sized municipality'
	},
	{
		name: 'Metropolis',
		radius: 50000.0,
		description: 'Large city'
	},
	{
		name: 'Province',
		radius: 500000.0,
		description: 'State, province, or other large administrative area'
	},
	{
		name: 'Neighborhood',
		radius: 1000.0,
		description: 'District, square or other neighborhood'
	}
])