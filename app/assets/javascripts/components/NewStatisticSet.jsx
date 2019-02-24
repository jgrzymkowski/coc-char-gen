const statistics = {
  strength: 'STR',
  constitution: 'CON',
  dexterity: 'DEX',
  intelligence: 'INT',
  power: 'POW',
  charisma: 'CHA'
}

class NewStatisticSet extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      characteristicSetOption: null,
      statisticSet: {
        strength: null,
        constitution: null,
        dexterity: null,
        intelligence: null,
        power: null,
        charisma: null
      },
      chosenValueIndex: null
    }
  }

  render() {
    return (
      <div className="page statistic-sets new">
        <div className="grid-x align-center">
          <div className="cell small-12 medium-7 large-5">
            <form method="post" action={`/dg/characters/${this.props.characterId}/statistic_sets`} >
              {this._renderHiddenInputs()}
              {this._renderNumberChooser()}
              {this._renderStatisticAssignment()}
            </form>
          </div>
        </div>
      </div>
    )
  }

  _disabled() {
    return !_.isNil(this.state.characteristicSetOption)
  }

  _renderNumberChooser() {
    const { characteristicSetOption } = this.state
    return (
      <fieldset className="fieldset">
        <legend>Choose Statistic Values</legend>
        <div className="callout primary">
          First, choose your numbers.  You can assign these values to statistics after you select a set.
        </div>
        <div>
          Select One:
        </div>
        <div id='field-set-options'>
          {_.map(Dg.CharacteristSetOptions, (option, i) => {
            let selectableness = 'selectable'
            if(characteristicSetOption == option) {
              selectableness = 'selected'
            } else if (!_.isNil(characteristicSetOption)) {
              selectableness = 'unselectable'
            }
            return (
              <div key={i} className={`statistic-set-option ${selectableness}`} id={option.id}>
                <div className="statistic-set-option-name">{option.name}</div>
                <div className="statistic-set-option-values">
                  {_.map(option.values, (v, i) => {
                    return (
                      <div key={i} className="statistic-set-option-value" onClick={this._onClickStatisticNumbers(option)}>
                        {v || '?'}
                      </div>
                    )
                  })}
                </div>
              </div>
            )
          })}
        </div>
        <div className='button-group tiny' id="option-select"> </div>
      </fieldset>
    )
  }

  _onClickStatisticNumbers(option) {
    return (event) => {
      event.preventDefault()

      const { characteristicSetOption } = this.state
      if(characteristicSetOption) return

      if(confirm(`Are you sure you want "${option.name}"? There is no going back...`)) {
        _roll = () => {
          return (Math.floor(Math.random() * 6) + 1) +
            (Math.floor(Math.random() * 6) + 1) +
            (Math.floor(Math.random() * 6) + 1)
        }

        let _selectedOption = option
        if(option.id == 'randomized') {
          _selectedOption.values = [_roll(), _roll(), _roll(), _roll(), _roll(), _roll()]
        }
      }
      this.setState({ characteristicSetOption: option })
    }
  }

  _renderStatisticAssignment() {
    const { characteristicSetOption, chosenValueIndex, statisticSet } = this.state
    if(_.isNil(characteristicSetOption)) { return }
    const unavailableValueIndices = _.filter(_.values(statisticSet), (i) => !_.isNil(i))

    const arrowLeft = _.isNil(chosenValueIndex) && unavailableValueIndices.length < 6
    const arrowRight = !_.isNil(chosenValueIndex) && unavailableValueIndices.length < 6
    return (
      <fieldset className="fieldset">
        <legend>Assign Statistics</legend>
        <div className="callout primary">
          Now, select a statistic value, and assign it to a statistic.
        </div>
        <div className="reset-link">
          <a onClick={this._onClickReset()}>Reset</a>
        </div>
        <div className="grid-x align-spaced">
          <div className="cell small-3">
            <div>
              <i className={`fa fa-arrow-down guidance-arrow ${arrowLeft ? '' : 'hidden'}`}></i>
            </div>
            {_.times(6, (index) => {
              let selectableness = 'unselectable'
              if(chosenValueIndex == index) {
                selectableness = 'selected'
              } else if (_.isNil(chosenValueIndex) && !_.includes(unavailableValueIndices, index)) {
                selectableness = 'selectable'
              }

              return <div
                key={index}
                className={`statistic-set-option ${selectableness}`}
                onClick={() => { if(selectableness == 'selectable') { this.setState({ chosenValueIndex: index}) }} }>
                {characteristicSetOption.values[index]}
              </div>
            })}
          </div>
          <div className="cell small-9 medium-7">
            <div>
              <i className={`fa fa-arrow-down guidance-arrow ${arrowRight ? '' : 'hidden'}`}></i>
            </div>
            {_.map(statistics, (abbreviation, statistic) => {
              let selectableness = 'unselectable'
              if(!_.isNil(chosenValueIndex)) {
                selectableness = 'selectable'
              } else if(!_.isNil(statisticSet[statistic])) {
                selectableness = 'selected'
              }
              return (
                <div key={statistic} className={`statistic-values statistic-set-option ${selectableness}`} onClick={this._onClickStatistic(statistic)}>
                  <div className="">{_.capitalize(statistic)} ({_.toUpper(abbreviation)})</div>
                  <div className="">
                    {characteristicSetOption.values[statisticSet[statistic]]}
                  </div>
                </div>
              )
            })}
            </div>
          </div>
          <div className="grid-x">
            <div className="cell small-12 derived-statistics-title">
              Derived Statistics:
            </div>
            <div className="cell small-8">
              <div className='assign-attribute-name grid-x'>
                <span className="small-12 medium-7">Hit Points (HP)</span>
                <span className='assign-attribute-subtext small-12 medium-5'>(STR + CON) ÷ 2</span>
              </div>
              <div className='assign-attribute-name  grid-x'>
                <span className="small-12 medium-7">Willpower (WP)</span>
                <span className='assign-attribute-subtext small-12 medium-5'>(POW)</span>
              </div>
              <div className='assign-attribute-name grid-x'>
                <span className="small-12 medium-7">Sanity (SAN)</span>
                <span className='assign-attribute-subtext small-12 medium-5'>(POW x 5)</span>
              </div>
              <div className='assign-attribute-name grid-x'>
                <span className="small-12 medium-7">Breaking Point (BP)</span>
                <span className='assign-attribute-subtext small-12 medium-5'>(SAN - POW)</span>
              </div>
            </div>
            {this._renderDerivedStatistics()}
          </div>
        <button type="submit" className={`button float-right ${this._disabled()}`}>Save</button>
      </fieldset>
    )
  }

  _onClickStatistic(statistic) {
    return (event) => {
      const { statisticSet, chosenValueIndex } = this.state
      statisticSet[statistic] = chosenValueIndex
      this.setState({ statisticSet, chosenValueIndex: null })
    }
  }

  _onClickReset() {
    return (event) => {
      event.preventDefault()
      const statisticSet = _.reduce(this.state.statisticSet, function(result, value, key) {
        result[key] = null
        return result
      }, {})
      this.setState({ chosenValueIndex: null, statisticSet })
    }
  }

  _renderDerivedStatistics() {
    const { statisticSet, characteristicSetOption } = this.state
    const strength = characteristicSetOption.values[statisticSet.strength]
    const constitution = characteristicSetOption.values[statisticSet.constitution]
    const power  = characteristicSetOption.values[statisticSet.power]
    const hitPoints = strength && constitution && Math.ceil((strength + constitution)/2)
    const sanity = power && power*5
    const breakingPoint = power && power*4
    return (
      <div className="cell small-4">
        <div className="statistic-value derived" id="hit-point">
          { hitPoints }&nbsp;
        </div>
        <div className="statistic-value derived" id="willpower">
          { power }&nbsp;
        </div>
        <div className="statistic-value derived" id="sanity">
          { sanity }&nbsp;
        </div>
        <div className="statistic-value derived" id="breaking-point">
          { breakingPoint }&nbsp;
        </div>
      </div>
    )
  }

  _renderHiddenInputs() {
    const { authenticityToken } = this.props
    const { statisticSet, characteristicSetOption } = this.state
    return (
      <div>
        <input type="hidden" name="authenticity_token" value={authenticityToken} />
        <input
          type="hidden"
          name="dg_statistic_set[strength]"
          id="dg_statistic_set_strength"
          value={_.isNil(statisticSet.strength) ? '' : characteristicSetOption.values[statisticSet.strength]} />
        <input
          type="hidden"
          name="dg_statistic_set[constitution]"
          id="dg_statistic_set_constitution"
          value={_.isNil(statisticSet.constitution) ? '' : characteristicSetOption.values[statisticSet.constitution]} />
        <input
          type="hidden"
          name="dg_statistic_set[dexterity]"
          id="dg_statistic_set_dexterity"
          value={_.isNil(statisticSet.dexterity) ? '' : characteristicSetOption.values[statisticSet.dexterity]} />
        <input
          type="hidden"
          name="dg_statistic_set[intelligence]"
          id="dg_statistic_set_intelligence"
          value={_.isNil(statisticSet.intelligence) ? '' : characteristicSetOption.values[statisticSet.intelligence]} />
        <input
          type="hidden"
          name="dg_statistic_set[power]"
          id="dg_statistic_set_power"
          value={_.isNil(statisticSet.power) ? '' : characteristicSetOption.values[statisticSet.power]} />
        <input
          type="hidden"
          name="dg_statistic_set[charisma]"
          id="dg_statistic_set_charisma"
          value={_.isNil(statisticSet.charisma) ? '' : characteristicSetOption.values[statisticSet.charisma]} />
      </div>
    )
  }
}

NewStatisticSet.propTypes = {
  characterId: PropTypes.string,
  authenticityToken: PropTypes.string
}
