Pokedex.Views.Pokemon = Backbone.View.extend({
  initialize: function () {
    this.$pokeList = this.$el.find('.pokemon-list');
    this.$pokeDetail = this.$el.find('.pokemon-detail');
    this.$newPoke = this.$el.find('.new-pokemon');
    this.$toyDetail = this.$el.find('.toy-detail');

    this.pokemon = new Pokedex.Collections.Pokemon();
    this.$pokeList.on('click', 'li.poke-list-item', this.selectPokemonFromList.bind(this));
    this.$pokeDetail.on('click', 'li.toy-list-item', this.selectToyFromList.bind(this));
    this.$newPoke.on('submit', this.submitPokemonForm.bind(this));
    //todo
    this.$el.find('select.toy-select').on('change', this.reassignToy.bind(this));
  },

  selectPokemonFromList: function (e) {
    var pokemonId = $(e.currentTarget).data('id');
    var pokemon = this.pokemon.get(pokemonId);
    this.renderPokemonDetail(pokemon);
  },

  addPokemonToList: function (pokemon) {
    this.$pokeList.append('<li class="poke-list-item" data-id=' +
                            pokemon.get('id') + '>' +
                            pokemon.get('name') +
                            " : " +
                            pokemon.get('poke_type') +
                            '</li>'
                          );
  },

  refreshPokemon: function () {
    var that = this;
    this.pokemon.fetch({
      success: function () {
        that.pokemon.each(function (pokemon) { that.addPokemonToList(pokemon); });
      }
    });
  },

  createPokemon: function (attributes, callback) {
    var newPokemon = new Pokedex.Models.Pokemon();
    var that = this;
    newPokemon.set(attributes);
    newPokemon.save({}, {
      success: function () {
        that.pokemon.add(newPokemon);
        that.addPokemonToList(newPokemon);
        callback(newPokemon);
      }
    });
  },

  renderPokemonDetail: function (pokemon) {
    var $pokeAttrs = $('<div class="detail"></div>');
    $pokeAttrs.append('<img src=' + pokemon.get('image_url') + '>');
    var attrKeys = _.keys(pokemon.attributes);
    attrKeys.forEach(function (key) {
      if (key !== 'id' && key !== 'image_url') {
        $pokeAttrs.append('<h5>' + key + ": " + pokemon.get(key) + '</h5><br>');
      }
    });
    this.$pokeDetail.html($pokeAttrs);
    var that = this;
    var toys = $('<ul class="toys"></ul>');
    pokemon.fetch({
      success: function () {
        pokemon.toys().each(function (toy) {
          that.addToyToList(toy);
        });
      }
    });
  },

  addToyToList: function (toy) {
    var listItem = $('<li class="toy-list-item" data-id=' + toy.get('id') +
                      ' data-pokemon-id=' + toy.get('pokemon_id') +
                      '>Name: ' + toy.get('name') +
                      'Happiness: ' + toy.get('happiness') +
                      'Price: ' + toy.get('price') + '</li>'
                    );
    this.$pokeDetail.append(listItem);
  },

  submitPokemonForm: function (e) {
    e.preventDefault();
    this.createPokemon($(e.target).serializeJSON(), this.renderPokemonDetail.bind(this));
  },

  renderToyDetail: function (toy) {
    var $toyAttrs = $('<div class="detail"></div>');
    $toyAttrs.append('<img src=' + toy.get('image_url') + '>');
    $toyAttrs.append('<h5>Name: ' + toy.get('name') + '</h5><br>');
    $toyAttrs.append('<h5>Happiness: ' + toy.get('happiness') + '</h5><br>');
    $toyAttrs.append('<h5>Price: ' + toy.get('price') + '</h5>');
    var $selectPoke = $('<select class= "toy-select" data-toy-id=' + toy.get('id') +
                            ' data-pokemon-id=' + toy.get('pokemon_id') +'></select>'
                       );


    this.pokemon.each(function (pokemon) {
      $selectPoke.append('<option value=' + pokemon.get('id') +
                                          ($selectPoke.data('pokemon-id') === pokemon.get('id') ? ' selected' : ' ') +
                                            '>' + pokemon.get('name') +
                                            '</option>'
                                          );
    });

    $toyAttrs.append($selectPoke);
    this.$toyDetail.html($toyAttrs);
  },

  reassignToy: function (e) {
    var pokemon = this.pokemon.get($(e.currentTarget).data('pokemon-id'));
    var toy = pokemon.toys().get($(e.currentTarget).data('toy-id'));
    var pokeId = $(e.currentTarget).data('pokemon-id');
    var newPokeId = $(e.currentTarget).val();
    var that = this;
    toy.set('pokemon_id', newPokeId);
    debugger;
    toy.save({}, {
      success: function () {
        that.pokemon.get(pokeId).toys().delete(toy);
        that.renderPokemonDetail();
        that.$toyDetail.empty();

      }
    });
  },

  selectToyFromList: function (e) {
    var toyId = $(e.currentTarget).data('id');
    var pokeId = $(e.currentTarget).data('pokemon-id');
    var toy = this.pokemon.get(pokeId).toys().get(toyId);
    this.renderToyDetail(toy);
    // debugger;
  }

});
