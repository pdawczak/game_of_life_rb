module OutOfIndexAccess
  refine NilClass do
    def [](i)
      []
    end
  end

  refine Array do
    def to_i
      0
    end
  end
end
