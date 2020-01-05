# Provided, don't edit
require 'directors_database'

# A method we're giving you. This "flattens"  Arrays of Arrays so: [[1,2],
# [3,4,5], [6]] => [1,2,3,4,5,6].

def flatten_a_o_a(aoa)
  result = []
  i = 0

  while i < aoa.length do
    k = 0
    while k < aoa[i].length do
      result << aoa[i][k]
      k += 1
    end
    i += 1
  end

  result
end

def movie_with_director_name(director_name, movie_data)
  { 
    :title => movie_data[:title],
    :worldwide_gross => movie_data[:worldwide_gross],
    :release_year => movie_data[:release_year],
    :studio => movie_data[:studio],
    :director_name => director_name
  }
end


# Your code after this point

def movies_with_director_key(name, movies_collection)
  # GOAL: For each Hash in an Array (movies_collection), provide a collection
  # of movies and a directors name to the movie_with_director_name method
  # and accumulate the returned Array of movies into a new Array that's
  # returned by this method.
  #
  # INPUT:
  # * name: A director's name
  # * movies_collection: An Array of Hashes where each Hash represents a movie
  #
  # RETURN:
  #
  # Array of Hashes where each Hash represents a movie; however, they should all have a
  # :director_name key. This addition can be done by using the provided
  # movie_with_director_name method
  
  index = 0 
  while index < movies_collection.length do
    movies_collection[index][:director_name] = name
    index += 1
  end
  movies_collection
end

def find_studio(array_of_hash)
  new_array = []
  list_of_studios = array_of_hash.map { |x| new_array << x.values[2]}.flatten.uniq
  list_of_studios
end

def gross_per_studio(collection)
  # GOAL: Given an Array of Hashes where each Hash represents a movie,
  # return a Hash that includes the total worldwide_gross of all the movies from
  # each studio.
  #
  # INPUT:
  # * collection: Array of Hashes where each Hash where each Hash represents a movie
  #
  # RETURN:
  #
  # Hash whose keys are the studio names and whose values are the sum
  # total of all the worldwide_gross numbers for every movie in the input Hash
  
  hash_of_studio_gross = {}
  list_of_studios = find_studio(collection)
  studio_index = 0
  while studio_index < list_of_studios.length do
    c_index = 0
    new_array_to_sum = []
    while c_index < collection.length do
     if collection[c_index].value?(list_of_studios[studio_index]) == false
       c_index += 1
     else
      new_array_to_sum << collection[c_index][:worldwide_gross]
      c_index += 1 
     end   
    end 
    hash_of_studio_gross[list_of_studios[studio_index]] = new_array_to_sum.sum
    studio_index += 1 
  end
  hash_of_studio_gross
end

def movies_with_directors_set(source)
  # GOAL: For each director, find their :movies Array and stick it in a new Array
  #
  # INPUT:
  # * source: An Array of Hashes containing director information including
  # :name and :movies
  #
  # RETURN:
  #
  # Array of Arrays containing all of a director's movies. Each movie will need
  # to have a :director_name key added to it.
  
  array_of_movies_with_directors = []
  director_index = 0
  while director_index < source.length do 
    movie_index = 0
    while movie_index < source[director_index][:movies].length do
      new_hash = {} 
      new_array =[] 
      new_hash[:title] = source[director_index][:movies][movie_index][:title]
      new_hash[:director_name] = source[director_index][:name]
      new_hash[:studio] = source[director_index][:movies][movie_index][:studio]
      new_hash[:worldwide_gross] = source[director_index][:movies][movie_index][:worldwide_gross]
      new_array << new_hash
      array_of_movies_with_directors << new_array
      movie_index += 1
    end
    director_index += 1
  end
 array_of_movies_with_directors
end


# ----------------    End of Your Code Region --------------------
# Don't edit the following code! Make the methods above work with this method
# call code. You'll have to "see-saw" to get this to work!

def studios_totals(nds)
  a_o_a_movies_with_director_names = movies_with_directors_set(nds)
  movies_with_director_names = flatten_a_o_a(a_o_a_movies_with_director_names)
  return gross_per_studio(movies_with_director_names)
end
