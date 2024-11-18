ActiveAdmin.register Skin do
  permit_params :name, :rarity, :splash_art, :loading_art, :champion_id

  index do
    selectable_column
    id_column
    column :name
    column :rarity
    column :champion
    column :created_at
    actions
  end

  filter :name
  filter :rarity
  filter :champion

  form do |f|
    f.inputs do
      f.input :name
      f.input :rarity, as: :select, collection: ['Common', 'Rare', 'Epic', 'Legendary']
      f.input :splash_art
      f.input :loading_art
      f.input :champion
    end
    f.actions
  end
end
