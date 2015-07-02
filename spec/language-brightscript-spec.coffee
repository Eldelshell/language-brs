{WorkspaceView} = require 'atom'
LanguageVbscript = require '../lib/language-brightscript'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "LanguageBrightScript", ->
  activationPromise = null

  beforeEach ->
    atom.workspaceView = new WorkspaceView
    activationPromise = atom.packages.activatePackage('language-brightscript')

  describe "when the language-brightscript:toggle event is triggered", ->
    it "attaches and then detaches the view", ->
      expect(atom.workspaceView.find('.language-brightscript')).not.toExist()

      # This is an activation event, triggering it will cause the package to be
      # activated.
      atom.workspaceView.trigger 'language-brightscript:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(atom.workspaceView.find('.language-brightscript')).toExist()
        atom.workspaceView.trigger 'language-brightscript:toggle'
        expect(atom.workspaceView.find('.language-brightscript')).not.toExist()
