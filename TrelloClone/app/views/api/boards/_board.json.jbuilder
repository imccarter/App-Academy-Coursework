json.extract! board, :title, :id
json.lists board.lists.order('ord'), partial: 'api/lists/list', as: :list
