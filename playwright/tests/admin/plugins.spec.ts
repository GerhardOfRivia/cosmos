/*
# Copyright 2022 OpenC3, Inc.
# All Rights Reserved.
#
# This program is free software; you can modify and/or redistribute it
# under the terms of the GNU Affero General Public License
# as published by the Free Software Foundation; version 3 with
# attribution addendums as found in the LICENSE.txt
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
*/

// @ts-check
import { test, expect } from 'playwright-test-coverage'

test.beforeEach(async ({ page }) => {
  await page.goto('/tools/admin/plugins')
  await expect(page.locator('.v-app-bar')).toContainText('Administrator')
  await page.locator('.v-app-bar__nav-icon').click()
})

test('shows and hides built-in tools', async ({ page }) => {
  await expect(page.locator('id=openc3-tool')).toContainText('openc3-demo')
  await expect(page.locator('id=openc3-tool')).not.toContainText('openc3-tool-admin')
  await expect(page.locator('id=openc3-tool')).not.toContainText('openc3-tool-autonomic')
  await expect(page.locator('id=openc3-tool')).not.toContainText('openc3-tool-base')
  await expect(page.locator('id=openc3-tool')).not.toContainText('openc3-tool-calendar')
  await expect(page.locator('id=openc3-tool')).not.toContainText('openc3-tool-cmdsender')
  await expect(page.locator('id=openc3-tool')).not.toContainText('openc3-tool-cmdtlmserver')
  await expect(page.locator('id=openc3-tool')).not.toContainText('openc3-tool-dataextractor')
  await expect(page.locator('id=openc3-tool')).not.toContainText('openc3-tool-dataviewer')
  await expect(page.locator('id=openc3-tool')).not.toContainText('openc3-tool-handbooks')
  await expect(page.locator('id=openc3-tool')).not.toContainText('openc3-tool-limitsmonitor')
  await expect(page.locator('id=openc3-tool')).not.toContainText('openc3-tool-packetviewer')
  await expect(page.locator('id=openc3-tool')).not.toContainText('openc3-tool-scriptrunner')
  await expect(page.locator('id=openc3-tool')).not.toContainText('openc3-tool-tablemanager')
  await expect(page.locator('id=openc3-tool')).not.toContainText('openc3-tool-tlmgrapher')
  await expect(page.locator('id=openc3-tool')).not.toContainText('openc3-tool-tlmviewer')

  await page.locator('text=Show Default Tools').click()
  await expect(page.locator('id=openc3-tool')).toContainText('openc3-demo')
  await expect(page.locator('id=openc3-tool')).toContainText('openc3-tool-admin')
  await expect(page.locator('id=openc3-tool')).toContainText('openc3-tool-autonomic')
  await expect(page.locator('id=openc3-tool')).toContainText('openc3-tool-base')
  await expect(page.locator('id=openc3-tool')).toContainText('openc3-tool-calendar')
  await expect(page.locator('id=openc3-tool')).toContainText('openc3-tool-cmdsender')
  await expect(page.locator('id=openc3-tool')).toContainText('openc3-tool-cmdtlmserver')
  await expect(page.locator('id=openc3-tool')).toContainText('openc3-tool-dataextractor')
  await expect(page.locator('id=openc3-tool')).toContainText('openc3-tool-dataviewer')
  await expect(page.locator('id=openc3-tool')).toContainText('openc3-tool-handbooks')
  await expect(page.locator('id=openc3-tool')).toContainText('openc3-tool-limitsmonitor')
  await expect(page.locator('id=openc3-tool')).toContainText('openc3-tool-packetviewer')
  await expect(page.locator('id=openc3-tool')).toContainText('openc3-tool-scriptrunner')
  await expect(page.locator('id=openc3-tool')).toContainText('openc3-tool-tablemanager')
  await expect(page.locator('id=openc3-tool')).toContainText('openc3-tool-tlmgrapher')
  await expect(page.locator('id=openc3-tool')).toContainText('openc3-tool-tlmviewer')
})

test('shows targets associated with plugins', async ({ page }) => {
  // Check that the openc3-demo contains the following targets:
  await expect(
    page.locator('[data-test=plugin-list] div[role=listitem]:has-text("openc3-demo")')
  ).toContainText('EXAMPLE')
  await expect(
    page.locator('[data-test=plugin-list] div[role=listitem]:has-text("openc3-demo")')
  ).toContainText('INST')
  await expect(
    page.locator('[data-test=plugin-list] div[role=listitem]:has-text("openc3-demo")')
  ).toContainText('INST2')
  await expect(
    page.locator('[data-test=plugin-list] div[role=listitem]:has-text("openc3-demo")')
  ).toContainText('SYSTEM')
  await expect(
    page.locator('[data-test=plugin-list] div[role=listitem]:has-text("openc3-demo")')
  ).toContainText('TEMPLATED')
})

// This is generated by the playwright github workflow via .github/workflows/playwright.yml
// Follow the steps there to generate a local copy for test
let plugin = 'openc3-pw-test'
let pluginGem = 'openc3-pw-test-1.0.0.gem'

test('installs a new plugin', async ({ page }) => {
  // Note that Promise.all prevents a race condition
  // between clicking and waiting for the file chooser.
  const [fileChooser] = await Promise.all([
    // It is important to call waitForEvent before click to set up waiting.
    page.waitForEvent('filechooser'),
    // Opens the file chooser.
    await page.locator('text=Click to select').click({ force: true }),
  ])
  await fileChooser.setFiles(`../${plugin}/${pluginGem}`)
  await expect(page.locator('.v-dialog')).toContainText('Variables')
  await page.locator('data-test=edit-submit').click()
  await expect(page.locator('[data-test=plugin-alert]')).toContainText('Started installing')
  // Plugin install can go so fast we can't count on 'Running' to be present
  // so just check for Complete
  await expect(page.locator('[data-test=process-list]')).toContainText(
    `Processing plugin_install: ${pluginGem} - Complete`,
    {
        timeout: 30000,
      }
    )
  await expect(
    page.locator(`[data-test=plugin-list] div[role=listitem]:has-text("${plugin}")`)
  ).toContainText('PW_TEST')
  // Show the process output
  await page
    .locator(
      `[data-test=process-list] div[role=listitem]:has-text("${plugin}") >> [data-test=show-output]`
    )
    .first()
    .click()
  await expect(page.locator('.v-dialog--active')).toContainText('Process Output')
  await expect(page.locator('.v-dialog--active')).toContainText(`Loading new plugin: ${pluginGem}`)
  await page.locator('.v-dialog--active >> button:has-text("Ok")').click()
})

test('edits existing plugin', async ({ page }) => {
  // Edit then cancel
  await page
    .locator(
      `[data-test=plugin-list] div[role=listitem]:has-text("${plugin}") >> [data-test=edit-plugin]`
    )
    .click()
  await expect(page.locator('.v-dialog')).toContainText('Variables')
  await page.locator('data-test=edit-cancel').click()
  await expect(page.locator('.v-dialog')).not.toBeVisible()
  // Edit and change a target name (forces re-install)
  await page
    .locator(
      `[data-test=plugin-list] div[role=listitem]:has-text("${plugin}") >> [data-test=edit-plugin]`
    )
    .click()
  await expect(page.locator('.v-dialog')).toContainText('Variables')
  await page.locator('.v-dialog .v-input:has-text("pw_test_target_name") >> input').fill('NEW_TGT')
  await page.locator('data-test=edit-submit').click()
  await expect(page.locator('[data-test=plugin-alert]')).toContainText('Started installing')
  // Plugin install can go so fast we can't count on 'Running' to be present
  // so just check for Complete ... note new installs append '__<TIMESTAMP>'
  let regexp = new RegExp(`Processing plugin_install: ${pluginGem}__.* - Complete`)
  await expect(page.locator('[data-test=process-list]')).toContainText(regexp, {
    timeout: 30000
  })
  // Ensure the target list is updated to show the new name
  await expect(
    page.locator(`[data-test=plugin-list] div[role=listitem]:has-text("${plugin}")`)
  ).not.toContainText('PW_TEST')
  await expect(
    page.locator(`[data-test=plugin-list] div[role=listitem]:has-text("${plugin}")`)
  ).toContainText('NEW_TGT')
  // Show the process output
  await page
    .locator(
      `[data-test=process-list] div[role=listitem]:has-text("${plugin}") >> [data-test=show-output]`
    )
    .first()
    .click()
  await expect(page.locator('.v-dialog--active')).toContainText('Process Output')
  // TODO: Should this be Loading new or Updating existing?
  // await expect(page.locator('.v-dialog--active')).toContainText('Updating existing plugin')
  await page.locator('.v-dialog--active >> button:has-text("Ok")').click()
})

test('deletes a plugin', async ({ page }) => {
  await page
    .locator(
      `[data-test=plugin-list] div[role=listitem]:has-text("${plugin}") >> [data-test=delete-plugin]`
    )
    .click()
  await expect(page.locator('.v-dialog')).toContainText('Confirm')
  await page.locator('[data-test=confirm-dialog-delete]').click()
  await expect(page.locator('[data-test=plugin-alert]')).toContainText('Removing plugin')
  // Plugin uninstall can go so fast we can't count on 'Running' to be present so check Complete
  let regexp = new RegExp(`Processing plugin_uninstall: ${pluginGem}__.* - Complete`)
  await expect(page.locator('[data-test=process-list]')).toContainText(regexp, {
    timeout: 60000,
  })
  await expect(page.locator(`[data-test=plugin-list]`)).not.toContainText(plugin)
  // Show the process output
  await page
    .locator(
      `[data-test=process-list] div[role=listitem]:has-text("plugin_uninstall") >> [data-test=show-output]`
    )
    .first()
    .click()
  await expect(page.locator('.v-dialog--active')).toContainText('Process Output')
  await expect(page.locator('.v-dialog--active')).toContainText(
    'PluginModel destroyed'
  )
  await page.locator('.v-dialog--active >> button:has-text("Ok")').click()
})