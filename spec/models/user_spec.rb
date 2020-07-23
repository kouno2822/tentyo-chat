require 'rails_helper'

RSpec.describe User, type: :model do

  it 'ユーザーネーム、メーアドレス、パスワード、パスワード(確認用)がある場合、有効である' do 
    user = build(:user)
    expect(user).to be_valid
  end

  it 'ユーザーネームがない場合、無効である' do
    user = build(:user, name: '')
    user.valid?
    expect(user.errors[:name]).to include("を入力してください")
  end

  it '重複したユーザーネームの場合、無効である' do 
    user = create(:user)
    another_user = build(:user, name: user.name)
    another_user.valid?
    expect(another_user.errors[:name]).to include("はすでに存在します")
  end

  it 'メールアドレスがない場合、無効である' do
    user = build(:user, email: '')
    user.valid?
    expect(user.errors[:email]).to include("を入力してください")
  end

  it '重複したメールアドレスの場合、無効である' do 
    user = create(:user)
    another_user = build(:user, email: user.email)
    another_user.valid?
    expect(another_user.errors[:email]).to include("はすでに存在します")
  end

  it 'メールアドレスに@とドメインがない場合、無効である' do
    user = build(:user, email: 'aaa')
    user.valid?
    expect(user.errors[:email]).to include("は不正な値です")
  end

  it 'パスワードがない場合、無効である' do
    user = build(:user, password: '')
    user.valid?
    expect(user.errors[:password]).to include("を入力してください")
  end

  it 'パスワードが6文字以上ない場合、無効である' do
    user = build(:user, password: '55555')
    user.valid?
    expect(user.errors[:password]).to include('は6文字以上で入力してください')
  end

  it 'パスワード（確認用）がない場合、無効である' do
    user = build(:user, password_confirmation: '')
    user.valid?
    expect(user.errors[:password_confirmation]).to include('を入力してください')
  end
  it 'パスワードが確認用と一致していない場合、無効である' do
    user = build(:user, password_confirmation: '666660')
    user.valid?
    expect(user.errors[:password_confirmation]).to include('とパスワードの入力が一致しません')
  end
end