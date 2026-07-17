import React from 'react';
import { mount, shallow } from 'enzyme';
import CohortDetails from './CohortDetails';

const CohortData = {
  cohortName: 'INTADMDF10',
  code: '.NET FSD',
  startedOn: '22-Feb-2022',
  status: 'Scheduled',
  coach: 'Aathma',
  trainer: 'Jojo Jose'
};

describe("Cohort Details Component", () => {
  
  test("should create the component", () => {
    const wrapper = shallow(<CohortDetails {...CohortData} />);
    expect(wrapper.exists()).toBeTruthy();
  });

  test("should initialize the props", () => {
    const wrapper = mount(<CohortDetails {...CohortData} />);
    expect(wrapper.props().cohortName).toEqual('INTADMDF10');
    expect(wrapper.props().code).toEqual('.NET FSD');
  });

  test("should display cohort code in h3", () => {
    const wrapper = mount(<CohortDetails {...CohortData} />);
    expect(wrapper.find('h3').text()).toContain('.NET FSD');
  });

  test("should always render same html", () => {
    const wrapper = shallow(<CohortDetails {...CohortData} />);
    expect(wrapper.html()).toMatchSnapshot();
  });

});
