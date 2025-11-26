// SPDX-FileCopyrightText: 2025 SAP SE or an SAP affiliate company and openmcp-project contributors
//
// SPDX-License-Identifier: Apache-2.0

package blueprints

import (
	"context"

	"github.com/spf13/cobra"
)

// NewBlueprintsCommand creates a new blueprints command.
func NewBlueprintsCommand(ctx context.Context) *cobra.Command {
	cmd := &cobra.Command{
		Use:     "blueprints",
		Aliases: []string{"blue", "blueprint", "bp"},
		Short:   "command to interact with blueprints stored in an oci registry",
	}

	cmd.AddCommand(NewValidationCommand(ctx))

	return cmd
}
