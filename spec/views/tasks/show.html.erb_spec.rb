# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'tasks/show', type: :view do
  before(:each) do
    @task = assign(:task, Task.create!(
                            title: 'Title',
                            description: 'Description',
                            state: 2
                          ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Description/)
    expect(rendered).to match(/2/)
  end
end
