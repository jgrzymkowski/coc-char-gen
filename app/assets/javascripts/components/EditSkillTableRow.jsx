class EditSkillTableRow extends React.Component {
  constructor(props) {
    super(props)
    this.state = { value: props.value }
  }

  render() {
    const { label, attribute } = this.props
    const { value } = this.state
    return (
      <tr>
        <td>{label}</td>
        <td>
          <input
            type="number"
            min="0"
            max="100"
            name={`dg_skill_set[${attribute}]`}
            id={`dg_skill_set_${attribute}`}
            value={value || ''}
            onChange={(event) => { this.setState({ value: event.target.value})}}/>
        </td>
      </tr>
    )
  }
}

EditSkillTableRow.propTypes = {
  label: PropTypes.string,
  attribute: PropTypes.string,
  percentage: PropTypes.number
}
