class RestaurantPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      # scope.all # Restaurant.all
      if user.admin?
        scope.all # admins podem ver tudo
      else
        scope.where(user:) # outros usuários só podem ver o que criaram
      end
    end
  end

  def show?
    true # todos podem ver o restaurante
  end

  def create?
    true # todos podem criar um restaurante
  end

  def update?
    owner?
  end

  def destroy?
    owner?
  end

  private

  def owner?
    # verificar se o usuário do restaurate é o usuário logado
    # record = @restaurant
    # record.user = @restaurant.user
    # user = current_user
    record.user == user
  end
end
