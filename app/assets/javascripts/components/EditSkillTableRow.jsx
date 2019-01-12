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
            type="text"
            name={`dg_skill_set[${attribute}]`}
            id={`dg_skill_set_${attribute}`}
            value={value || ''} />
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
