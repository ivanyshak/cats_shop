# frozen_string_literal: true

module CatsShop
  class CatCreatorService
    attr_reader :list

    def initialize(*list)
      @list = list
    end

    def generate_cats
      list.compact.flatten.each do |cat|
        Cat.find_or_create_by!(
          name: cat['name'] || cat['title'],
          price: cat['price'] || cat['cost'],
          location: cat['location'],
          image: cat['image'] || cat['img']
        )
      end
    end
  end
end
