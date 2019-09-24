# frozen_string_literal: true

def detect_language(filename)
  case File.extname(filename).downcase
  when '.c' then 'C'
  when '.py' then 'Python'
  when '.rb' then 'Ruby'
  when '.c++', '.cpp', '.cxx' then 'Cpp'
  end
end
