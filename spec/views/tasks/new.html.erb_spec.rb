# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'tasks/new', type: :view do
  before(:each) do
    assign(:task, Task.new(
                    title: 'MyString',
                    description: 'MyString',
                    state: 1
                  ))
  end

  it 'renders new task form' do
    render

    assert_select 'form[action=?][method=?]', tasks_path, 'post' do
      assert_select 'input[name=?]', 'task[title]'

      assert_select 'input[name=?]', 'task[description]'

      assert_select 'input[name=?]', 'task[state]'
    end
  end
end